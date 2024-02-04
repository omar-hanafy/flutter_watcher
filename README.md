# Watcher State Management

* [Watcher State Management](#watcher-state-management)
  * [Overview](#overview)
  * [Initialization](#initialization)
  * [Using ValueWatch Widget and .watch](#using-valuewatch-widget-and-watch)
  * [watchWhen](#watchwhen)
  * [CachedWatcher](#cachedwatcher)
  * [Utilities and Handling Changes](#utilities-and-handling-changes)
  * [Other Useful Helpers](#other-useful-helpers)
  * [Flutter Controllers With Watcher.](#flutter-controllers-with-watcher)
    * [TextEditingController](#texteditingcontroller)
    * [AnimationController](#animationcontroller)
  * [Full Counter Example](#full-counter-example)
  * [Contributions](#contributions)
  * [License](#license)

## Overview

`flutter_watcher` is an intuitive and efficient state management package for Flutter. Acting as a wrapper around Flutter's `ValueNotifier` and `ValueListenableBuilder`, it offers a more user-friendly syntax, including the `CachedWatcher` for persistent state management, transforming the complexity of state management into a simpler, cleaner, and more maintainable approach.

## Initialization

```dart
final counter = Watcher<int>(0);

// also you can use the `.watcher` extension on any type.
final counter = 0.watcher;
final boolValue = false.watcher;

// Or use the original Watchers.
final listWatcher = ListWatcher<int>([1, 2, 3]);

// All custom types are also supported.
final userWatcher = User().watcher; // creates a Watcher<User>
```

## Using `ValueWatch` Widget and `.watch`

```dart
final isLoading = false.watcher;

@override
Widget build(BuildContext context) {
  ...
  ValueWatch<bool>(
    builder: (context, value) => MyWidget(value),
    watcher: isLoading, // Your watcher instance.
  ),
  ...
}

// or with the `.watch` extension
@override
Widget build(BuildContext context) {
  ...
  isLoading.watch(
    (value) => MyWidget(value),
  ),
  ...
}
// MyWidget here will automatically update its value when isLoading.value changes.
```

## `watchWhen`

The `watchWhen` feature in the `ValueWatch` widget provides a way
to conditionally rebuild a widget based on specific criteria.
It Allows defining custom conditions under which the widget should update,
offering more control and potentially improving performance by reducing unnecessary rebuilds.

```dart
final counter = Watcher<int>(0);

ValueWatch<int>(
  watcher: counter,
  watchWhen: (previous, current) => current % 2 == 0, // Rebuild only when the current value is even
  builder: (context, value) {
    return Text('Even Counter: $value');
  },
);
```

## CachedWatcher

`CachedWatcher` is an abstract class extending the standard `Watcher` with added local caching capabilities. it is designed to be subclassed for specific data types.

### Simple Usage

In this package there is a good set of extensions and classes that help you create a `CachedWatcher<T>` in a simple way.

```dart
// Example: Using a subclass for integers
final counter = IntCachedWatcher(0, 'counter_key'); // with class.
final counter = 0.cachedWatcher('counter_key'); // with extension.

// BoolCachedWatcher, ListCachedWatcher, DateTimeCachedWatcher, and so on for premitive types are supported
// in simple usage.
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

Any CachedWatcher instance can be used with the `ValueWatch` widget and `.watch` extension.

## Utilities and Handling Changes

### Description

Extensions such as `updateIf`, `onChange`, `debounce`, `map`, and `combineWith` provide powerful utilities for responding to changes, debouncing actions, transforming, or combining multiple `Watcher` instances.

### Examples

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
  final streamWatcher = valueWatcher.stream;
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

## Other Useful Helpers

Allowing direct manipulation of values in a more natural and concise way, mirroring the operations you'd typically
perform on the data types themselves. Here are some samples:

### Bool

- **toggle**: Toggle the value of `Watcher<bool>`.

- **symbols**: The built in `|` `&` `^` are supported.

  ```dart
  boolWatcher.toggle(); // Toggles the boolean value
  ```

### List

- **addAll**: Add multiple items to `Watcher<List<E>>`.

- **remove**: Remove an item from the list.

- **clear**: Clear all items in the list.

- and all `List` built-in functions are supported

  ```dart
  listWatcher.addAll([4, 5]); // Adds items to the list
  listWatcher.remove(item);   // Removes an item
  listWatcher.clear();        // Clears the list
  // and more
  ```

### Num/int/double

- **increment**: Increment the value of `Watcher<num>`.

- **decrement**: Decrement the value.

- and all `Num` built-in functions are supported

  ```dart
  numWatcher.increment(); // Increments the number
  numWatcher.decrement(); // Decrements the number
  // and more
  ```

### Map

- **putIfAbsent**: Add a key-value pair if the key is not already in the map.

- **remove**: Remove a key-value pair.

- and all `Map` built-in functions are supported

  ```dart
  mapWatcher.putIfAbsent(key, () => value); // Adds key-value pair if absent
  mapWatcher.remove(key);                  // Removes the key-value pair
  // and more
  ```

### Set

- **add**: Add an item to `Watcher<Set<T>>`.

- **removeAll**: Remove all items from the set.

- and all `Set` built-in functions are supported

  ```dart
  setWatcher.add(item);       // Adds an item
  setWatcher.removeAll(items); // Removes all specified items
  // and more
  ```

### Uri

- **updatePath**: Update the path of `Watcher<Uri>`.

- and all `Uri` built-in functions are supported

  ```dart
  uriWatcher.updatePath(newPath); // Updates the URI path
  // and more
  ```

## Flutter Controllers With Watcher.

The `Watcher` and  `.watch` extension provides seamless integration with various native Flutter controllers, enhancing the development of reactive UIs. Below are examples demonstrating how Watcher can be utilized with common Flutter controllers:

### TextEditingController

Watcher can reactively handle text input changes, making it ideal for scenarios like live character counts or conditional UI updates based on user input.

```dart
final textEditingController = TextEditingController();

textEditingController.watch(
	(TextEditingValue value) {
    return Column(
      children: [
        TextField(controller: textEditingController),
        Text('Character Count: ${value.text.length}'),
      ],
    );
  },
);
```

### AnimationController

Incorporate Watcher with AnimationController for dynamic UI elements that respond to animation state changes, enhancing the visual experience.

```dart
final animationController = AnimationController(
  vsync: this,
  duration: Duration(seconds: 2),
)..repeat(reverse: true);

animationController.watch(
  (double value) {
    double scale = 1 + value; // Adjust scale based on animation value
    return Transform.scale(
      scale: scale,
      child: MyAnimatedWidget(),
    );
  },
);
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
          child: ValueWatch<int>(
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

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a pull request in the [repository](https://github.com/omar-hanafy/flutter_watcher).

## License

`flutter_watcher` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
