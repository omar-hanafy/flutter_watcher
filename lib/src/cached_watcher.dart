import 'dart:async';

import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';
import 'package:flutter_watcher/src/exceptions/parsing_exception.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// CachedWatcher
///
/// A specialized version of [Watcher] that adds local caching capabilities.
/// Ideal for use cases where persistent state management is required,
/// such as saving user preferences, caching network responses, or maintaining temporary state across app restarts.
///
/// The [CachedWatcher] extends [Watcher] and inherits its reactive state management capabilities,
/// while adding the functionality to automatically write to and read from a local cache.
///
/// [CachedWatcher] is designed to be extended for various data types,
/// with abstract `read` and `write` methods that need to be implemented in subclasses.
/// This design allows for flexible and type-specific serialization and deserialization strategies for cached data.
///
/// Usage:
/// To use CachedWatcher, create a subclass for the specific data type you wish to cache.
/// Implement the `read` and `write` methods to define how data is serialized and deserialized.
///
/// Example Subclass Implementation:
/// ```dart
/// class StringCachedWatcher extends CachedWatcher<String> {
///   StringCachedWatcher(String initialValue, String key) : super(initialValue, key: key);
///
///   @override
///   String? read(dynamic data) => data as String;
///
///   @override
///   dynamic write(String value) => value;
/// }
/// ```
///
/// Parameters:
/// - [initialValue]: The starting value for the watcher.
/// - [key]: A unique string key used for storing and retrieving the cached data.
///
/// Abstract Methods:
/// - [read]: An abstract method that should be implemented to define how the stored data is read and converted back into the expected type.
/// - [write]: An abstract method that should be implemented to define how the state is serialized and stored in the local cache.
///
/// Additional Methods:
/// - [startCaching]: Enables caching of the watcher's value.
/// - [stopCaching]: Disables caching of the watcher's value.
/// - [deleteCache]: Clears the cache for this specific [CachedWatcher].
/// - [deleteAllCaches]: Static method to clear all caches associated with [CachedWatcher].
abstract class CachedWatcher<T> extends Watcher<T> {
  CachedWatcher(
    this.initialValue, {
    String? key,
  }) : super(initialValue) {
    this.key = key ?? T.toString();
    _init();
  }

  final T initialValue;

  /// [key]
  ///
  /// A string key used for storing and retrieving the cached data in local storage.
  /// This key is essential for ensuring that the data is uniquely identified and
  /// can be correctly persisted and accessed across app sessions.
  ///
  /// if not provided the [T] is used instead for example CachedWatcher<UserModel> its key will be 'UserModel'.
  /// so make sure to provide it whenever you want to uniquely identify your data.
  late final String key;

  /// [write]
  ///
  /// A callback function that defines how the state is serialized for storage in the local cache.
  /// This function is responsible for converting the state into a format suitable for storage,
  /// which can include various primitive types such as
  /// [num], [double], [int], [bool], [String], [BigInt], [DateTime], [Uint8List],
  /// as well as collections like [List], [Set], and [Map] MUST be containing primitive types.
  ///
  /// The [write] function is invoked whenever the state needs to be written to the cache,
  /// ensuring the state is stored in an efficient and accessible manner.
  ///
  /// NOTE: if you write any object that is not a primitive type, an [UnSupportedType] exception will be raised.
  FutureOr<dynamic> write(T value);

  /// [read]
  ///
  /// A callback function that is used to read and convert the stored data back into the expected type
  /// when the [CachedWatcher] is initialized. This function handles various primitive types and collections
  /// containing primitives, ensuring that the data retrieved from the local cache is correctly transformed
  /// back into its original state or the state type [T]. The [read] callback is crucial for the accurate
  /// restoration of the cached state, facilitating a seamless user experience across app sessions.
  ///
  /// the [read] function returns data only when the [write] function gets called before and returned a value.
  ///
  /// NOTE: make sure that the [dynamic] data that you are getting from the [read] function is properly
  /// converted into the type that you wrote before using the [write] function.
  FutureOr<T?> read(dynamic data);

  /// [isCaching]
  ///
  /// A getter that returns a boolean indicating whether caching is currently active for this [CachedWatcher].
  /// If [true], changes to the watcher's value are automatically written to the local cache.
  /// If [false], the caching functionality is disabled, and changes are not written to the cache.
  bool get isCaching => _isCaching;

  /// [stopCaching]
  ///
  /// Disables the caching of the watcher's value. When invoked, this method sets [isCaching] to [false],
  /// meaning subsequent changes to the watcher's value will not be written to the local cache.
  /// This method can be used to temporarily pause caching, for example, during specific app states
  /// where caching is not desirable.
  void stopCaching() {
    _isCaching = false;
    refresh();
  }

  /// [startCaching]
  ///
  /// Enables the caching of the watcher's value. When invoked, this method sets [isCaching] to [true],
  /// allowing changes to the watcher's value to be automatically written to the local cache.
  /// This method can be used to resume caching after it has been stopped.
  void startCaching() {
    _isCaching = true;
    refresh();
  }

  /// [deleteCache]
  ///
  /// Asynchronously clears the cache for this specific [CachedWatcher] instance.
  /// This method deletes the data associated with this watcher's [key] from the local storage,
  /// effectively resetting its cached state to its [initialValue].
  Future<void> deleteCache() async {
    await _BaseStoredWatcher._reset(key);
    value = initialValue;
  }

  /// [deleteAllCaches]
  ///
  /// A static method that asynchronously clears all caches associated with [CachedWatcher].
  /// This method is useful for scenarios where a complete reset of all cached states is required,
  /// such as during a sign-out process or when clearing app data.
  static Future<void> deleteAllCaches() async => _BaseStoredWatcher._resetAll();

  /// [isCaching]
  ///
  /// A getter that returns a boolean indicating whether caching is currently active for this [CachedWatcher].
  /// If [true], changes to the watcher's value are automatically written to the local cache.
  /// If [false], the caching functionality is disabled, and changes are not written to the cache.
  bool _isCaching = true;

  /// this is the starting point of the caching process when initializing a new [CachedWatcher]
  Future<void> _init() async {
    await _BaseStoredWatcher._init();
    final box = await _BaseStoredWatcher._box;
    final storedValue = box.containsKey(key) ? box.get(key) : null;
    final data = await read(storedValue);
    if (data != null) setWithoutNotify(data);
  }

  Future<dynamic> get cache async {
    final box = await _BaseStoredWatcher._box;
    return box.get(key);
  }

  @override
  set value(T newValue) {
    super.value = newValue;
    if (isCaching) _writeCache(write(newValue));
  }

  @override
  set v(T newValue) => this.value = newValue;

  Future<void> _writeCache(FutureOr<dynamic> data, {Box<dynamic>? box}) async =>
      _BaseStoredWatcher._updateValue(await data, key: key, box: box);
}

abstract class _BaseStoredWatcher {
  static const String _boxName = '_StoredWatcherBox';
  static Box<dynamic>? _staticBox;

  static bool _isHiveInit = false;

  static Future<void> _init() async {
    if (!_isHiveInit) {
      await Hive.initFlutter();
      _isHiveInit = true;
    }
  }

  static Future<Box<dynamic>> get _box async {
    await _init();
    if (_staticBox == null || !(_staticBox?.isOpen ?? false)) {
      try {
        _staticBox = await Hive.openBox(_boxName);
      } catch (_) {}
    }
    return _staticBox!;
  }

  // Static method to clear the entire box
  static Future<void> _resetAll() async {
    final box = await _box;
    await box.clear();
  }

  static Future<void> _updateValue(
    dynamic data, {
    required String key,
    Box<dynamic>? box,
  }) async {
    if (data != null && !isPrimitiveType(data)) throw UnSupportedType();
    if (box != null) return box.put(key, data);
    await (await _box).put(key, data);
  }

  static Future<void> _reset(String key) async {
    final box = await _box;
    await box.delete(key);
  }
}
