import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// Watcher Extensions
///
/// This file, watcher_extensions.dart, contains a series of extensions for various data types,
/// enabling them to be directly converted into [Watcher] and [CachedWatcher] instances. These extensions
/// add simplicity and fluidity to the state management process in Flutter applications by allowing
/// direct and intuitive conversions from basic data types to their respective watcher types.
///
/// The extensions cover a wide range of data types, including primitive types like [bool], [num], [int],
/// [double], [String], and [DateTime], as well as more complex types like [Uri], [Color], [List]T>`, and [Map]K, V>`.
/// Nullable versions of these types are also provided, ensuring comprehensive coverage and flexibility in state management.
///
/// Usage:
///
/// With these extensions, you can easily convert a value to a [Watcher] or [CachedWatcher] instance. For example:
/// ```dart
/// final myBool = true;
/// final myBoolWatcher = myBool.watcher; // Creates a Watcher instance for a boolean value.
///
/// final myString = 'Hello';
/// // Creates a CachedWatcher instance for a String value.
/// final myStringCachedWatcher = myString.cachedWatcher('my_string_key');
/// ```
///
/// These extensions provide a convenient and efficient way to integrate state management into your Flutter
/// application, leveraging the capabilities of the flutter_watcher package. They simplify the creation of
/// both [Watcher] and [CachedWatcher] instances, making your code more concise, readable, and maintainable.
extension WatchExtension<T> on T {
  /// directly make [Watcher] instance from [T].
  Watcher<T> get watcher => Watcher<T>(this);

  /// directly make [CachedWatcher] instance from [T].
  CachedWatcher<T> cachedWatcher({
    required ReadCallBack<T> read,
    required WriteCallBack<T> write,
    String? key,
  }) =>
      CachedWatcher(
        this,
        key: key,
        write: write,
        read: read,
      );
}

extension BoolWatcherEx on bool {
  /// directly make [Watcher] instance from [bool].
  Watcher<bool> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [bool].
  CachedWatcher<bool> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToBool,
      );
}

extension NullableBoolWatcherEx on bool? {
  /// directly make [Watcher] instance from [bool].
  Watcher<bool?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [bool].
  CachedWatcher<bool?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToBool,
      );
}

extension NumWatcherEx on num {
  /// directly make [Watcher] instance from [num].
  Watcher<num> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [num].
  CachedWatcher<num> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToNum,
      );
}

extension NullableNumWatcherEx on num? {
  /// directly make [Watcher] instance from [num].
  Watcher<num?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [num].
  CachedWatcher<num?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToNum,
      );
}

extension DoubleWatcherEx on double {
  /// directly make [Watcher] instance from [double].
  Watcher<double> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [double].
  CachedWatcher<double> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToDouble,
      );
}

extension NullableDoubleWatcherEx on double? {
  /// directly make [Watcher] instance from [double].
  Watcher<double?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [double].
  CachedWatcher<double?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToDouble,
      );
}

extension DateTimeWatcherEx on DateTime {
  /// directly make [Watcher] instance from [DateTime].
  Watcher<DateTime> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [DateTime].
  CachedWatcher<DateTime> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToDateTime,
      );
}

extension NullableDateTimeWatcherEx on DateTime? {
  /// directly make [Watcher] instance from [DateTime].
  Watcher<DateTime?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [DateTime].
  CachedWatcher<DateTime?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToDateTime,
      );
}

extension IntWatcherEx on int {
  /// directly make [Watcher] instance from [int].
  Watcher<int> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [int].
  CachedWatcher<int> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToInt,
      );
}

extension NullableIntWatcherEx on int? {
  /// directly make [Watcher] instance from [int].
  Watcher<int?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [int].
  CachedWatcher<int?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToInt,
      );
}

extension StringWatcherEx on String {
  /// directly make [Watcher] instance from [String].
  Watcher<String> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [String].
  CachedWatcher<String> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToString,
      );
}

extension NullableStringWatcherEx on String? {
  /// directly make [Watcher] instance from [String].
  Watcher<String?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [String].
  CachedWatcher<String?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToString,
      );
}

extension ColorWatcherEx on Color {
  /// directly make [Watcher] instance from [Color].
  Watcher<Color> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Color].
  CachedWatcher<Color> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v.toHex(),
        read: (dynamic data) => data?.toString().toColor,
      );
}

extension NullableColorWatcherEx on Color? {
  /// directly make [Watcher] instance from [Color].
  Watcher<Color?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Color].
  CachedWatcher<Color?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v?.toHex(),
        read: (dynamic data) => data?.toString().toColor,
      );
}

extension UriWatcherEx on Uri {
  /// directly make [Watcher] instance from [Uri].
  Watcher<Uri> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Uri].
  CachedWatcher<Uri> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v.toString(),
        read: tryToUri,
      );
}

extension NullableUriWatcherEx on Uri? {
  /// directly make [Watcher] instance from [Uri].
  Watcher<Uri?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Uri].
  CachedWatcher<Uri?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v.toString(),
        read: tryToUri,
      );
}

extension ListWatcherEx<T> on List<T> {
  /// directly make [Watcher] instance from [List].
  Watcher<List<T>> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [List].
  CachedWatcher<List<T>> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToList,
      );
}

extension NullableListWatcherEx<T> on List<T>? {
  /// directly make [Watcher] instance from [List].
  Watcher<List<T>?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [List].
  CachedWatcher<List<T>?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToList,
      );
}

extension MapWatcherEx<K, V> on Map<K, V> {
  /// directly make [Watcher] instance from [Map].
  Watcher<Map<K, V>> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Map].
  CachedWatcher<Map<K, V>> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToMap,
      );
}

extension NullableMapWatcherEx<K, V> on Map<K, V>? {
  /// directly make [Watcher] instance from [Map].
  Watcher<Map<K, V>?> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Map].
  CachedWatcher<Map<K, V>?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToMap,
      );
}
