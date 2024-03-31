# Watcher State Management

Flutter Watcher is an alternative to ValueNotifier. It provides convenient syntax, built-in asynchronous safety, automatic tracking of changes within complex data structures, and value caching capabilities. Additionally, Flutter Watcher includes rich widgets to handle not only Watcher objects but any Listenable type.

* [Quick Sample](#quick-sample)
* [The Watcher Class](#the-watcher-class)
* [ValueNotifier vs. Watcher](#valuenotifier-vs-watcher)
* [Watcher Types](#watcher-types)
   * [Native-like Watchers](#native-like-watchers)
   * [Extension-based Watchers](#extension-based-watchers)
   * [Quick Initialization](#quick-initialization)n
* [Watcher Widgets](#watcher-widgets)
   * [WatchValue](#watchvalue)
   * [Watch](#watch)
   * [WatchAll](#watchall)
   * [Widgets Extensions](#widgets-extensions)
* [CachedWatcher](#cachedwatcher)
   * [Simple Usage](#simple-usage)
   * [Advanced Usage (Custom Types)](#advanced-usage-custom-types)
   * [Initialization Properties](#initialization-properties)
* [Utilities](#utilities)
* [Full Counter Example](#full-counter-example)
* [FAQ](#faq)
* [Contributions & Issues](#contributions)
* [License](#license)
* [Support](#support)


## Quick Sample

```dart
// create watcher instance
final counter = 0.watcher;

// use it in the WatchValue widget.
counter.watchValue(
  builder: (value) => Text('Counter: $value'),
),

// manpulate the counter value anywhere
onPress: () => counter.increment()
```

## The Watcher Class

### Initialization

```dart
final myWatcher = Watcher<int>(0);
```

- This is the basic initialization of watcher, please see [watcher types](#watcher-types), and [quick initialization](#quick-initialization) for a recommended approach.

### Modifying the Value

```dart
myWatcher.value = newValue; // Updates the value and notifies listeners
```

### Checking for Disposal

```dart
print(myWatcher.isDisposed) // whether the watcher instnace is disposed or not.
```

check the [Utilities](#utilities) for more.

## **ValueNotifier vs. Watcher**

- **Asynchronous Safety**: `Watcher` enhances safety in asynchronous contexts with a `safeMode` and `isDisposed` check, preventing errors when a notifier is updated after being disposed. This is a common issue with `ValueNotifier` in async scenarios that `Watcher` effectively addresses.
- **Internal Changes Notification**: Unlike `ValueNotifier`, `Watcher` automatically notifies listeners of internal changes in complex data types like lists and maps, thanks to [custom types](#watcher-types) like `ListWatcher` and `MapWatcher`. This ensures UI components can react dynamically to state changes.
- **Simplified Syntax**: `Watcher` offers a more concise syntax, reducing boilerplate and improving code readability . For instance, what requires a verbose `ValueListenableBuilder` setup with `ValueNotifier` can be more succinctly done using `.watchValue(builder: (value) {})` with `Watcher`. for more see [quick initialization](#quick-initialization) and [widgets extensions](#widgets-extensions).
- **Versatile Reactivity**: `Watcher` provides specialized widgets (`WatchValue`, `Watch`, `WatchAll`) that cater to various reactive scenarios, supporting not only `Watcher` instances but any `ValueListenable` or `Listenable` object.  For better control, these widgets include optional parameters like `watchWhen` (to conditionally trigger rebuilds based on value changes) and `threshold` (to limit rebuild frequency and optimize performance).

## Watcher Types

While you can basically create any watcher type using the default initializer `Watcher<T>()` , This package comes with a suite of `Watcher` types, each designed for specific data structures and primitives, providing a seamless and intuitive way to manage state that aligns closely with Dart's native types.

### Native-like Watchers

These watchers act like their native counterparts. directly implement their corresponding native types

- **ListWatcher**: Implements `List<T>`, supporting all list operations.
- **MapWatcher**: Implements `Map<K, V>`, with full `Map` functionality.
- **SetWatcher**: Behaves like a native `Set`, supporting all set operations.
- Additional types include **DateWatcher**, **DurationWatcher**, and **UriWatcher** for managing `DateTime`, `Duration`, and `Uri` types respectively.

### Extension-based Watchers

Due to the constraints of the Dart programming language, not all watchers can directly implement their corresponding native types. However, This package provides a set of extension-based watchers to bridge this gap.

- **IntWatcher**: Facilitates integer operations.
- **StringWatcher**: Enables string manipulations.
- **BoolWatcher**: Simplifies boolean state management.
- Others include **NumWatcher** for numeric values, **DoubleWatcher** for floating-point operations, and **ColorWatcher** for color management.

### Quick Initialization

The `Watcher` Package comes with a cool extension called `.watcher`, The `.watcher`  is assigned to any object/value in dart and automatically detects the type of the watcher for you, for example `12.watcher` creates an `IntWatcher`, `false.watcher`, creates a `BoolWatcher`, and for custom types it creates the default `Watcher<T>`.

## Watcher Widgets

Widgets designed to reacts to `Watcher` value changes.  These widgets, `WatchValue`, `Watch`, and `WatchAll`, along with their corresponding extensions, no only reacts to `Watcher` instances, but with any `ValueListenable` or `Listenable` instance. Below, we'll dive into each widget and understand when to use them.

### WatchValue

`WatchValue` is designed to rebuild its child widget in response to changes in a specific `ValueListenable` value, including `Watcher` instances. It's particularly useful for displaying or reacting to single data changes in your UI.

**Parameters:**

- **watcher:** The `ValueListenable` (or `Watcher`) instance you want to listen to.
- **builder**: Builds the widget in response to changes
- **threshold (optional)**: Limits rebuild frequency to improve performance.
- **watchWhen (optional)**: Conditionally triggers rebuilds based on value changes.

#### Usage

```dart
WatchValue<int>(
  watcher: counter, // Your Watcher<int> instance
  builder: (context, value) => Text('Counter: $value'),
  watchWhem: (prev, curr) => prev != curr, // optional
  threshold: Duration(milliseconds: 100), // optional
),
```

### Watch

Extends UI reactivity to any `Listenable` object, accommodating broader changes beyond value updates, such as animations or scroll positions.

**Parameters:**

- **watcher:** Any `Listenable` object, not limited to `ValueListenable` or `Watcher`.
- **builder**: Builds the widget in response to changes. Does not receive value since listenable might not has value.
- **threshold (optional)**: Limits rebuild frequency to improve performance.
- **watchWhen (optional)**: Conditionally triggers rebuilds based on value changes.

#### Usage

```dart
Watch(
  watcher: scrollController, // Any Listenable object including watcher
  builder: (context) => MyCustomScrollView(scrollController.offset),
  watchWhen: () => scrollController.offset > 100,
  threshold: Duration(milliseconds: 300),
),
```

### WatchAll

`WatchAll` is designed for scenarios where your UI depends on multiple `Listenable` objects. It rebuilds its child widget when any of the provided listenable change.

**Parameters:**

- **watchers:** A list of `Listenable` objects including watchers to observe.
- **builder:** Builds the widget in response to changes. Does not receive value since listenable might not has value.
- **threshold (optional)**: Limits rebuild frequency to improve performance.
- **watchWhen (optional)**: Conditionally triggers rebuilds based on value changes.

#### Usage

```dart
final scrollCotroller = ScrollController();
final textCotroller = TextEditingController();
final counter = 0.watcher;
final listenables = <Listenable>[scrollCotroller, textCotroller, counter];

WatchAll(
  watchers: listenables,
  builder: (context) => ContentWidget(),
  watchWhen: () => scrollController.offset > 100,
  threshold: Duration(milliseconds: 300),
),
```

**WARNING:** The `Watch` and`WatchAll` widgets reacts to `Listenable` objects which might frequently change  their states and thus triggers a rebuild. which might lead to unnecessary rebuilds if not used wisely, so consider using the `watchWhen` and `threshold` to limit and avoid unnecessary rebuilds.

### Widgets Extensions

For a simpler syntax, you can use the `.watchValue`, `.watch`, and `.watchAll`  to create their corresponding Widget:

```dart
final counter = 0.watcher;
final scrollCotroller = ScrollController();
final listenables = <Listenable>[scrollCotroller, counter];

// .watchValue
counter.watchValue(
  builder: (value) => Text('Counter: $value'),
),
// .watch
scrollCotroller.watch(
  builder: (context) => Text('Current Scroll Position: ${scrollCotroller.position}'),
),
// .watchAll
listenables.watchAll(
  builder: (context) => Text('Position: ${scrollCotroller.position}, Counter: $counter'),
),
```

**Note** that each one does not need the watcher/s since they are already used in the context.

## CachedWatcher

`CachedWatcher` is an abstract class extending the standard `Watcher` with added local caching capabilities. it is designed to be subclassed for specific data types.

### Simple Usage

In this package there is a good set of extensions and classes that help you create a `CachedWatcher<T>` in a simple way
with built-in types.

```dart
// Example: Using a subclass for integers
final counter = IntCachedWatcher(0, 'counter_key'); // with class.
final counter = 0.cachedWatcher('counter_key'); // with extension.

// BoolCachedWatcher, ListCachedWatcher, DateTimeCachedWatcher, and so on for premitive/built-in types are supported.

// use it just like any watcher.
counter.watchValue(
  builder: (value) => Text('Counter: $value'),
),
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
    // Implement logic to serialize value to be cached
    // use premitive/built-in data types to avoid errors.
    // for example write the token when `AuthState is success`. 
  }
}
```

### Initialization Properties

- **`initialValue`**: The starting value for the watcher.
- **`key` (Optional)**: A unique identifier for the `CachedWatcher`'s stored data, used to save and retrieve the cached
  value from local storage. Default is the type name

The `CachedWatcher` instance can be used with all [Watcher Widgets](#watcher-widgets).

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

- **refresh**: Notifies listeners to force UI refresh.

  ```dart
  myWatcher.refresh();
  ```

- **dispose**: disposes the watcher and closes all listeners.

  ```dart
  myWatcher.dispose();
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

While there is a great state management available I can recommend to use watcher in some cases:

- If your app is simple and won't require complex state management solution watcher is a good choice.
- If you already use strong state management, but you want to manage a specific (simple) feature or component in your
  app `Watcher` can help with that. Sometimes when you use BLoC its just not convenient to `emit` new state for the sake
  to toggle a switcher in the screen.
- If you are using the built in `ValueNotifer` but need a simpler syntax, avoiding errors if state updates after disposal, and need your UI to automatically react to changes within lists, maps, or similar data structures watcher is the best alternative for you.
- If you want to use singletons, watcher instances in a singleton class is a great choice, for example you can use
  CachedWatcher with user settings, or Themes, etc.

**How to move from ValueNotifier to Watcher:**

1. **For new state elements:** Start using the `Watcher` class directly (`final counter = 0.watcher`).
2. **Gradual Transition:** Your existing `ValueNotifier` instances can be used seamlessly with Watcher's widgets (like `.watchValue`, `.watch`, and `.watchAll`) . This lets you transition gradually without needing to immediately convert all your ValueNotifiers.
3. **Replace as Needed** As your project evolves, consider replacing ValueNotifier instances with `Watcher` where you specifically want the advantages of simplified syntax, built-in asynchronous safety, or automatic tracking of complex data changes.

**Does it offer any dependency injection?**

No, the flutter watcher package designed to be simple, you can use it with `Provider` if you wish to make your watcher
instance available in your widget tree.

**Are there any examples that demonstrate the use of the package?**

I am planning to publish a documentation website soon with useful examples and detailed documentation.

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a
pull request in the [repository](https://github.com/omar-hanafy/flutter_watcher).

## License

`flutter_watcher` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

## Support

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
