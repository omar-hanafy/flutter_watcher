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
/// final myStringCachedWatcher = myString.cachedWatcher(
///   key: 'my_string_key',
///   write: (value) => value,
///   read: (value) => value.toString(),
/// );
/// ```
///
/// These extensions provide a convenient and efficient way to integrate state management into your Flutter
/// application, leveraging the capabilities of the flutter_watcher package. They simplify the creation of
/// both [Watcher] and [CachedWatcher] instances, making your code more concise, readable, and maintainable.
extension WatchExtension<T> on T {
  Watcher<T> get watcher => Watcher<T>(this);

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

/// directly convert [bool] into [Watcher] and [CachedWatcher] instances.
extension BoolWatcherEx on bool {
  Watcher<bool> get watcher => Watcher(this);

  CachedWatcher<bool> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToBool,
      );
}

/// directly convert [bool] into [Watcher] and [CachedWatcher] instances.
extension NullableBoolWatcherEx on bool? {
  Watcher<bool?> get watcher => Watcher(this);

  CachedWatcher<bool?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToBool,
      );
}

/// directly convert [num] into [Watcher] and [CachedWatcher] instances.
extension NumWatcherEx on num {
  Watcher<num> get watcher => Watcher(this);

  CachedWatcher<num> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToNum,
      );
}

/// directly convert [num] into [Watcher] and [CachedWatcher] instances.
extension NullableNumWatcherEx on num? {
  Watcher<num?> get watcher => Watcher(this);

  CachedWatcher<num?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToNum,
      );
}

/// directly convert [double] into [Watcher] and [CachedWatcher] instances.
extension DoubleWatcherEx on double {
  Watcher<double> get watcher => Watcher(this);

  CachedWatcher<double> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToDouble,
      );
}

/// directly convert [double] into [Watcher] and [CachedWatcher] instances.
extension NullableDoubleWatcherEx on double? {
  Watcher<double?> get watcher => Watcher(this);

  CachedWatcher<double?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToDouble,
      );
}

/// directly convert [DateTime] into [Watcher] and [CachedWatcher] instances.
extension DateTimeWatcherEx on DateTime {
  Watcher<DateTime> get watcher => Watcher(this);

  CachedWatcher<DateTime> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToDateTime,
      );
}

/// directly convert [DateTime] into [Watcher] and [CachedWatcher] instances.
extension NullableDateTimeWatcherEx on DateTime? {
  Watcher<DateTime?> get watcher => Watcher(this);

  CachedWatcher<DateTime?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToDateTime,
      );
}

/// directly convert [int] into [Watcher] and [CachedWatcher] instances.
extension IntWatcherEx on int {
  Watcher<int> get watcher => Watcher(this);

  CachedWatcher<int> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToInt,
      );
}

/// directly convert [int] into [Watcher] and [CachedWatcher] instances.
extension NullableIntWatcherEx on int? {
  Watcher<int?> get watcher => Watcher(this);

  CachedWatcher<int?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToInt,
      );
}

/// directly convert [String] into [Watcher] and [CachedWatcher] instances.
extension StringWatcherEx on String {
  Watcher<String> get watcher => Watcher(this);

  CachedWatcher<String> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToString,
      );
}

/// directly convert [String] into [Watcher] and [CachedWatcher] instances.
extension NullableStringWatcherEx on String? {
  Watcher<String?> get watcher => Watcher(this);

  CachedWatcher<String?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToString,
      );
}

/// directly convert [Color] into [Watcher] and [CachedWatcher] instances.
extension ColorWatcherEx on Color {
  Watcher<Color> get watcher => Watcher(this);

  CachedWatcher<Color> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v.toHex(),
        read: (dynamic data) => data?.toString().toColor,
      );
}

/// directly convert [Color] into [Watcher] and [CachedWatcher] instances.
extension NullableColorWatcherEx on Color? {
  Watcher<Color?> get watcher => Watcher(this);

  CachedWatcher<Color?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v?.toHex(),
        read: (dynamic data) => data?.toString().toColor,
      );
}

/// directly convert [Uri] into [Watcher] and [CachedWatcher] instances.
extension UriWatcherEx on Uri {
  Watcher<Uri> get watcher => Watcher(this);

  CachedWatcher<Uri> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v.toString(),
        read: tryToUri,
      );
}

/// directly convert [Uri] into [Watcher] and [CachedWatcher] instances.
extension NullableUriWatcherEx on Uri? {
  Watcher<Uri?> get watcher => Watcher(this);

  CachedWatcher<Uri?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v.toString(),
        read: tryToUri,
      );
}

/// directly convert [List] into [Watcher] and [CachedWatcher] instances.
extension ListWatcherEx<T> on List<T> {
  Watcher<List<T>> get watcher => Watcher(this);

  CachedWatcher<List<T>> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToList,
      );
}

/// directly convert [List] into [Watcher] and [CachedWatcher] instances.
extension NullableListWatcherEx<T> on List<T>? {
  Watcher<List<T>?> get watcher => Watcher(this);

  CachedWatcher<List<T>?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToList,
      );
}

/// directly convert [Map] into [Watcher] and [CachedWatcher] instances.
extension MapWatcherEx<K, V> on Map<K, V> {
  Watcher<Map<K, V>> get watcher => Watcher(this);

  CachedWatcher<Map<K, V>> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToMap,
      );
}

/// directly convert [Map] into [Watcher] and [CachedWatcher] instances.
extension NullableMapWatcherEx<K, V> on Map<K, V>? {
  Watcher<Map<K, V>?> get watcher => Watcher(this);

  CachedWatcher<Map<K, V>?> cachedWatcher(String key) => CachedWatcher(
        this,
        key: key,
        write: (v) => v,
        read: tryToMap,
      );
}
