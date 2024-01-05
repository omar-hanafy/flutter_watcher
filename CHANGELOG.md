### 1.0.3

- All extensions for the `Watcher<T>` class in Flutter have been enhanced.
  Included all missing actions for each `Watcher<T>` extension.
  Updated documentation for each action to provide clearer guidance and use-case examples.
    - These extensions allow for direct manipulation of the data types within `Watcher<T>`,
      mirroring operations typically performed on the underlying data types themselves.

### Example Usage

```dart
final boolWatcher = true.watcher;
boolWatcher.toggle();

final counter = 10.watcher;
counter.increment(2);

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
