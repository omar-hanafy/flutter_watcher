# Watcher State Management

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
```

## Using `ValueWatch` Widget and `.watch`

```dart
final isLoading = false.watcher;

@override
Widget build(BuildContext context) {
  ...
  ValueWatch<bool>(
    builder: (context, value) => MyWidget(value), // Builder function
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

CachedWatcher is a wrapper around the standard Watcher, with local caching capabilities, Ideal for persisting state between app sessions. This feature allows efficient storage and retrieval of data, thereby optimizing app performance and user experience.

### Usage

CachedWatcher is straightforward to use. Here's a basic example:

```dart
  // Initialize a CachedWatcher with a key.
  final counter = 0.cachedWatcher('counter_key');

	// use it just like any watcher 
  @override
  Widget build(BuildContext context) {
    ...
     Center(
        child: counter.watch(
          (value) => Text('Counter: $value'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
				// the incremented counter is automatically cached.
        // when the app restarts it will be back (as long as the key is the same).
        onPressed: () => counter.increment(), 
        child: const Icon(Icons.add),
      ),
    );
    ...
}
```

### CachedWatcher (Advanced Use Cases)

CachedWatcher's flexibility allows it to handle a variety of advanced scenarios, making it a versatile tool for state management. Here's a deeper look into its initialization properties and how they can be leveraged:

### Initialization Properties

- **`initialValue`**: The initial value of the watcher. It's the starting point for your CachedWatcher's state.
- **`key`**: A unique identifier for the CachedWatcher's stored data. This key is used to save and retrieve the cached value from local storage.
- **`read`**: A callback function that provides the nullable value of the type of creation allowing to manipulate the stored value back to the expected type when initializing the CachedWatcher. **(uses the default value if not defined or returns null).**
- **`write`**: A callback function that specifies how to convert and store the value in local storage, which will be returned later in the `read` function.

### Custom Data Handling

Using `read` and `write`, you can manage how data is transformed and stored. For instance, if you are working with a custom object, you might want to convert it to a JSON string before writing to local storage and then parse it back to the object when reading, for example.

```dart
// Using CachedWatcher with a custom object e.g. Singleton
final loadState = LoadState.initial.cachedWatcher(
  'user_key',
  read: (dynamic json) {
    if(json != null) {
      return LoadState.loaded(user: User.fromJson(toMap(json)));
    }
    return null; // uses the default state. LoadState.initial()
  }
  write: (state) => state is Loaded ? state.user.toJson() : null,
);
// where LoadState is a custom state object defined in your app.
```

## Utilities and Handling Changes

### Description

Extensions such as `updateIf`, `onChange`, `debounce`, `map`, and `combineWith` provide powerful utilities for responding to changes, debouncing actions, transforming, or combining multiple `Watcher` instances.

### Usage Examples

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

  ```dart
  boolWatcher.toggle(); // Toggles the boolean value
  ```

### List

- **addAll**: Add multiple items to `Watcher<List<E>>`.

- **remove**: Remove an item from the list.

- **clear**: Clear all items in the list.

  ```dart
  listWatcher.addAll([4, 5]); // Adds items to the list
  listWatcher.remove(item);   // Removes an item
  listWatcher.clear();        // Clears the list
  // and more
  ```

### Num/int/double

- **increment**: Increment the value of `Watcher<num>`.

- **decrement**: Decrement the value.

  ```dart
  numWatcher.increment(); // Increments the number
  numWatcher.decrement(); // Decrements the number
  // and more
  ```

### Map

- **putIfAbsent**: Add a key-value pair if the key is not already in the map.

- **remove**: Remove a key-value pair.

  ```dart
  mapWatcher.putIfAbsent(key, () => value); // Adds key-value pair if absent
  mapWatcher.remove(key);                  // Removes the key-value pair
  // and more
  ```

### Set

- **add**: Add an item to `Watcher<Set<T>>`.

- **removeAll**: Remove all items from the set.

  ```dart
  setWatcher.add(item);       // Adds an item
  setWatcher.removeAll(items); // Removes all specified items
  // and more
  ```

### Uri

- **updatePath**: Update the path of `Watcher<Uri>`.

  ```dart
  uriWatcher.updatePath(newPath); // Updates the URI path
  // and more
  ```

## Flutter Controllers With .watch widget.

The `.watch` provides seamless integration with various native Flutter controllers, enhancing the development of reactive UIs. Below are examples demonstrating how Watcher can be utilized with common Flutter controllers:

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

Contributions to this package are welcome.
If you have any suggestions, issues, or feature requests,
please create a pull request in the [repository](https://github.com/omar-hanafy/flutter_watcher).

## License

`flutter_watcher` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
