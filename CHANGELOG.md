### 2.1.2+1

- updated the package description to be more concise.

### 2.1.2

- CHORE: Updated [flutter_helper_utils](https://pub.dev/packages/flutter_helper_utils) to latest.
- Updated the readme.

### 2.1.1

- refactored some internal code,
- updated the README.

### 2.1.0+2

- Updated some docs.

### 2.1.0

#### Enhancements

- Enhanced all the `Watcher` and `CachedWatcher` classes.
    - To improve usability, we recommend using custom classes for built-in types, such
      as `ListWatcher<E>`, `MapWatcher<K, V>`, `DateTimeWatcher`, etc. These specialized classes are designed to behave
      just like
      their native counterparts. For instance, you can use `ListWatcher<E>` with a `for` loop just as you would with any
      standard `List`. However, When using the `.watcher` extension, there's no need to update your code; it
      automatically creates the appropriate
      type based on your context.

### 2.0.0

#### New Features

- **Stream to Watcher**: Introduced `toWatcher` extension for streams, enabling conversion of any stream into
  a `Watcher`.

- **Cached Data Access**: Added `cache` getter in `CachedWatcher` for direct cached data access outside the `read`
  function.

- **isDisposed in Watcher**: Added `isDisposed` in the Watcher. it is useful when you want to safely do some operations
  on the `Watcher` without getting exception if it gets disposed.

- **Watch Widget**: New `Watch` widget added for reacting to changes in any `Listenable`, not limited to `Watcher`.

- **WatchAll Widget**: Introduced `WatchAll` widget, similar to `Watch` but for a list of `Listenable` instances,
  monitoring changes in each.

#### Breaking Changes

- **Widget Renaming**: Renamed `WatchValue` Widget to `WatchValue`.

- The `prevValue` is removed from the Watcher class and now available only through the watchWhen in the all watcher
  widgets.

- **Extension Modification**: Modified `.watch` extension; it no longer provides the value in the builder function.
  Use `.watchValue` instead.

- **CachedWatcher Update**: `CachedWatcher` is now abstract, requiring subclasses to implement `read` and `write`
  methods for enhanced custom data handling.

  **Changes**:
    - Before: `final typeCachedWatcher = Type().cachedWatcher(read: .., write: ..);`
    - Now: `final typeCachedWatcher = TypeCachedWatcher(); // TypeCachedWatcher extends CachedWatcher`
    - Primitive types usage remains the same: `final counter = 0.cachedWatcher('counter_key');`

### 1.0.4

- This version returns the `ListValueNotifierEx` Accidentally removed from the previous version.

- Added new `NullableIterableValueNotifierEx` for Nullable `Iterable` values inside the `Watcher`.

### 1.0.3

- All extensions for the `Watcher<T>` class in Flutter have been enhanced.
  Included all missing actions for each `Watcher<T>` extension.
  Updated documentation for each action to provide clearer guidance and use-case examples.
    - These extensions allow for direct manipulation of the data types within `Watcher<T>`,
      mirroring operations typically performed on the underlying data types themselves.

### Example Usage

```dart

final boolWatcher = true.watcher;
boolWatcher.toggle
();

final counter = 10.watcher;
counter.increment
(2);

final urlWatcher = Uri.parse("https://example.com").watcher;
urlWatcher.updatePath("/newpage"); // without the extension u would use `urlWatcher.value.updatePath("/newpage");` 

final listWatcher = [1,2,3].watch;
listWatcher.clear();
```

### 1.0.2

- **UPDATE**: update [flutter_helper_utils](https://pub.dev/packages/flutter_helper_utils)
  version boundaries to be `'>=3.0.0'`

### 1.0.1

- **UPDATE**: Updated the docs.

### 1.0.0

- **INITIAL**: Initial release.
