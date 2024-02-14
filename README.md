# Watcher State Management

- [Overview](#overview)
- [Initialization](#initialization)
- [Widgets](#widgets)
  * [`WatchValue`](#-watchvalue-)
  * [`Watch`](#-watch-)
  * [`WatchAll`](#-watchall-)
  * [Widgets Extensions](#widgets-extensions-)
- [CachedWatcher](#cachedwatcher)
  * [Simple Usage](#simple-usage)
  * [Advanced Usage (Custom Types)](#advanced-usage--custom-types-)
  * [Initialization Properties](#initialization-properties)
- [Utilities](#utilities)
- [Supports for built-in types](#supports-for-built-in-types)
- [Full Counter Example](#full-counter-example)
- [FAQ](#faq)
- [Contributions](#contributions)
- [License](#license)
- [Support](#support)

## Overview

Simple and efficient state management package for Flutter. Acting as a wrapper around Flutter's `ValueNotifier`, it offers a more user-friendly syntax, including the `CachedWatcher` used to cache watcher values, transforming the complexity of state management into a simpler, cleaner, and more maintainable approach.

## Initialization

```dart
final counter = Watcher<int>(0);

// also you can use the `.watcher` extension on any type.
final counter = 0.watcher;
final boolValue = false.watcher;

// Or use the Watcher classes.
final listWatcher = ListWatcher<int>([1, 2, 3]);

// All custom types are also supported.
final userWatcher = User().watcher; // creates a Watcher<User>
```

## Widgets

### `WatchValue`

A widget that reacts to changes of value of  `Watcher` instance and any `ValueNotifier`.

#### Usage

```dart
final isLoading = false.watcher;

@override
Widget build(BuildContext context) {
  ...
  WatchValue<bool>(
    watcher: isLoading, // Your watcher instance.
    threshold: Duration(milliseconds: 300), // (optional) rebuilds every specific duration.
		watchWhen: (prev, curr) => prev != curr, // (optional) rebuilds only upon condition.
    builder: (context, value) => MyWidget(value),
  ),
  ...
}
```

### `Watch`

A widget that reacts to changes of  `Watcher`, `ValueNotifier` or any `Listenable` instance such as `ScrollController`, `AnimationController`, `TextEdititngController` etc.

#### Usage

```dart
final scrollController = ScrollController();

@override
Widget build(BuildContext context) {
  ...
  Watch(
    watcher: scrollController, // any listener instance.
    builder: (context) => MyWidget(isLoading.value), // the builder which reacts to listener changes.
    // threshold and watchWhen named params are also available.
  ),
  ...
}
```

### `WatchAll`

A widget that reacts to changes of values of  multpele instances of any `Listener` including `Watcher`.

#### Usage

```dart
  final counter = 0.watcher;
  final lastUpdated = DateTime.now().watcher();

  @override
  Widget build(BuildContext context) {
    ...
  WatchAll(
        watchers: [
          counter,
          lastUpdated,
        ],
     	 // threshold and watchWhen named params are also available.
	      builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Counter value is $counter'),
              Text('String message is $lastUpdated'),
            ],
          );
        },
      ),
    ...
  }
```

### Widgets Extensions:

You can use the extensions in the Watcher to create any of the `Watch` widgets quickly and in simpler syntax.

* Use `watcher.watchValue(...)` to create `WatchValue` widget.
* Use `watcher.watch(...)` to create `Watch` widget.
* Use `<Watcher>[].watchAll(...)` to create `WatchAll` widget.

**Note** that when you use the extension you no longer need to pass the `watcher` as parameter.

**Sample:**

```dart
final isLoading = false.watcher;

@override
Widget build(BuildContext context) {
  ...
  isLoading.watchValue(
    builder: (value) => MyWidget(value),
  ),
  ...
}
```

## CachedWatcher

`CachedWatcher` is an abstract class extending the standard `Watcher` with added local caching capabilities. it is designed to be subclassed for specific data types.

### Simple Usage

In this package there is a good set of extensions and classes that help you create a `CachedWatcher<T>` in a simple way with built-in types.

```dart
// Example: Using a subclass for integers
final counter = IntCachedWatcher(0, 'counter_key'); // with class.
final counter = 0.cachedWatcher('counter_key'); // with extension.

// BoolCachedWatcher, ListCachedWatcher, DateTimeCachedWatcher, and so on for premitive types are supported
```

### Advanced Usage (Custom Types) 

Subclasses can be created for any custom type, providing tailored serialization and deserialization strategies for different kinds of data stored in local cache.

```dart
class AuthService extends CachedWatcher<AuthState> {
  AuthService() : super(AuthState.initial, key: 'AuthServiceKey'); // Default key is the type name 'AuthState'

  @override
  AuthState? read(dynamic data) {
    // Implement logic to deserialize data from cache
    // for example return success and assign data to ur token.
  }

  @override
  dynamic write(AuthState value) {
    // Implement logic to serialize value to cache
    // for example write the token when AuthState is success. 
  }
}
```

### Initialization Properties

- **`initialValue`**: The starting value for the watcher.
- **`key` (Optional)**: A unique identifier for the `CachedWatcher`'s stored data, used to save and retrieve the cached
  value from local storage. Default is the type name

 The`CachedWatcher` instance can be used with all `Watch` [widgets](#widgets).

## Utilities

- **updateIf**: Update the value conditionally.

  ```dart
  intWatcher.updateIf((val) => val < 10, 5);
  ```

- **onChange**: Perform action on value change.

  ```dart
  stringWatcher.onChange((val) => print(val));
  // it returns call back that disposes the listener do not forget to call it in your close/dispose methods.
  ```

- **stream**: Convert `Watcher` changes into a stream.

  ```dart
  final streamWatcher = watcherInstance.stream;
  streamWatcher.listen((value) {
    // Handle the stream of changes
  });
  ```

- **debounce**: Debounce value changes.

  ```dart
  numWatcher.debounce(Duration(seconds: 1), (val) => print(val));
  ```

- **map**: Transform the value to another type.

  ```dart
  final stringWatcher = intWatcher.map((val) => val.toString());
  ```

- **combineWith**: Combine with another `Watcher`.

  ```dart
  final combinedWatcher = intWatcher.combineWith(stringWatcher, (int a, String b) => '$a and $b');
  ```

## Supports for built-in types

Watcher has built support for all built in types such is `IntWatcher` for `int` , `ListWatcher` for `List` , and `MapWatcher` for `Map`, etc... Allowing direct manipulation of values in a more natural and concise way, mirroring the operations you'd typically
perform on the data types themselves. Here are some samples:

### BoolWatcher

- **toggle**: Toggle the value of `Watcher<bool>`.

- **symbols**: The built in `|` `&` `^` are supported.

  ```dart
  boolWatcher.toggle(); // Toggles the boolean value
  ```

### ListWatcher, and SetWatcher

- **addAll**: Add multiple items to `Watcher<List<E>>`.

- **remove**: Remove an item from the list.

- **clear**: Clear all items in the list.

- and all `List` built-in functions are supported

  ```dart
  listWatcher.addAll([4, 5]);
  listWatcher.remove(item);
  listWatcher.clear();
  for(final item in listWatcher)
  // and so on.
  ```

### Num/Int/DoubleWatcher

- **increment**: Increment the value of `Watcher<num>`.

- **decrement**: Decrement the value.

- and all `Num` built-in functions are supported

  ```dart
  numWatcher.increment();
  numWatcher.decrement();
  numWatcher.abs();
  numWatcher.toDouble();
  numWatcher.toInt();
  // and so on.
  ```

### MapWatcher

- **putIfAbsent**: Add a key-value pair if the key is not already in the map.

- **remove**: Remove a key-value pair.

- and all `Map` built-in functions are supported

  ```dart
  mapWatcher.putIfAbsent(key, () => value);
  mapWatcher.remove(key);
  mapWathcer.keys.map((e) => ...);
  // and so on.
  ```

### UriWatcher

- **updatePath**: Update the path of `Watcher<Uri>`.

- and all `Uri` built-in functions are supported

  ```dart
  uriWatcher.updatePath(newPath); // Updates the URI path
  uriWatcher.replace(scheme: newScheme);
  // and so on.
  ```

## Full Counter Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

main() => runApp(MyCounter());

class MyCounter extends StatelessWidget {
  MyCounter({super.key});

  final counter = 0.watcher;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Counter',
      home: Scaffold(
        appBar: AppBar(title: const Text('Watch Counter')),
        body: Center(
          child: WatchValue<int>(
            watcher: counter,
            builder: (context, value) {
              return Text('Counter: $value');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

## FAQ

**Why should I use Watcher:**

While there is a greate state management available I can recommend to use watcher in some cases:

- If your app is simple and wont require complex state management solution watcher is a good choice.
- If you already use strong state management, but you want to manage a specific (simple) feature or component in your app `Watcher` can help with that. Sometimes when you use BLoC its just not convenient to `emit` new state for the sake to toggle a switcher in the screen.
- If you want to use singletons, watcher instances in a singleton class is a greate choice, for example you can use CachedWatcher with user settings, or Themes, etc.

**Does it offer any dependcy injection?**

No, the flutter watcher package designed to be simple, you can use it with `Provider` if you wish to make your watcher instance available in your widget tree.

**Is there any examples that demonstrate the use of the package?**

I am planning to publish a documentation website soon with useful examples and detailed documentation.

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a pull request in the [repository](https://github.com/omar-hanafy/flutter_watcher).

## License

`flutter_watcher` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

## Support

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
