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
extension WatchExtension<T extends Object> on T {
  /// directly make [Watcher] instance from [T].
  Watcher<T> get watcher => Watcher<T>(this);
}

/// BoolWatcherEx
///
/// Extension on boolean values to provide easy access to creating a [Watcher] and [CachedWatcher] for booleans.
extension BoolWatcherEx on bool {
  /// directly make [Watcher] instance from [bool].
  Watcher<bool> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [bool].
  CachedWatcher<bool> cachedWatcher(String key) => BoolCachedWatcher(
        this,
        key,
      );
}

/// NumWatcherEx
///
/// Extension on numeric values to provide easy access to creating a [Watcher] and [CachedWatcher] for numeric types.
extension NumWatcherEx on num {
  /// directly make [Watcher] instance from [num].
  Watcher<num> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [num].
  CachedWatcher<num> cachedWatcher(String key) => NumCachedWatcher(
        this,
        key,
      );
}

/// DoubleWatcherEx
///
/// Extension on double values to provide easy access to creating a [Watcher] and [CachedWatcher] for double types.
extension DoubleWatcherEx on double {
  /// directly make [Watcher] instance from [double].
  Watcher<double> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [double].
  CachedWatcher<double> cachedWatcher(String key) => DoubleCachedWatcher(
        this,
        key,
      );
}

/// IntWatcherEx
///
/// Extension on integer values to provide easy access to creating a [Watcher] and [CachedWatcher] for integers.
extension IntWatcherEx on int {
  /// directly make [Watcher] instance from [int].
  Watcher<int> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [int].
  CachedWatcher<int> cachedWatcher(String key) => IntCachedWatcher(
        this,
        key,
      );
}

/// DateTimeWatcherEx
///
/// Extension on DateTime to provide easy access to creating a [Watcher] and [CachedWatcher] for DateTime objects.
extension DateTimeWatcherEx on DateTime {
  /// directly make [Watcher] instance from [DateTime].
  Watcher<DateTime> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [DateTime].
  CachedWatcher<DateTime> cachedWatcher(String key) =>
      DateTimeCachedWatcher(this, key);
}

/// StringWatcherEx
///
/// Extension on String to provide easy access to creating a [Watcher] and [CachedWatcher] for String values.
extension StringWatcherEx on String {
  /// directly make [Watcher] instance from [String].
  Watcher<String> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [String].
  CachedWatcher<String> cachedWatcher(String key) => StringCachedWatcher(
        this,
        key,
      );
}

/// ColorWatcherEx
///
/// Extension on Color to provide easy access to creating a [Watcher] and [CachedWatcher] for Color objects.
extension ColorWatcherEx on Color {
  /// directly make [Watcher] instance from [Color].
  Watcher<Color> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Color].
  CachedWatcher<Color> cachedWatcher(String key) => ColorCachedWatcher(
        this,
        key,
      );
}

/// UriWatcherEx
///
/// Extension on Uri to provide easy access to creating a [Watcher] and [CachedWatcher] for Uri objects.
extension UriWatcherEx on Uri {
  /// directly make [Watcher] instance from [Uri].
  Watcher<Uri> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Uri].
  CachedWatcher<Uri> cachedWatcher(String key) => UriCachedWatcher(
        this,
        key,
      );
}

/// ListWatcherEx<T>
///
/// Extension on List<T> to provide easy access to creating a [Watcher] and [CachedWatcher] for lists of any (primitive types)[https://dart.dev/language/built-in-types].
extension ListWatcherEx<T> on List<T> {
  /// directly make [Watcher] instance from [List].
  Watcher<List<T>> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [List].
  CachedWatcher<List<T>> cachedWatcher(String key) => ListCachedWatcher(
        this,
        key,
      );
}

/// MapWatcherEx<K, V>
///
/// Extension on Map<K, V> to provide easy access to creating a [Watcher] and [CachedWatcher] for maps of any key-value (primitive types)[https://dart.dev/language/built-in-types].
extension MapWatcherEx<K, V> on Map<K, V> {
  /// directly make [Watcher] instance from [Map].
  Watcher<Map<K, V>> get watcher => Watcher(this);

  /// directly make [CachedWatcher] instance from [Map].
  CachedWatcher<Map<K, V>> cachedWatcher(String key) => MapCachedWatcher(
        this,
        key,
      );
}

/// BoolWatcherExNullable
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable boolean values.
extension BoolWatcherExNullable on bool? {
  Watcher<bool?> get watcher => Watcher(this);

  CachedWatcher<bool?> cachedWatcher(String key) => BoolCachedWatcherNullable(
        this,
        key,
      );
}

/// NumWatcherExNullable
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable numeric values.
extension NumWatcherExNullable on num? {
  Watcher<num?> get watcher => Watcher(this);

  CachedWatcher<num?> cachedWatcher(String key) => NumCachedWatcherNullable(
        this,
        key,
      );
}

/// DoubleWatcherExNullable
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable double values.
extension DoubleWatcherExNullable on double? {
  Watcher<double?> get watcher => Watcher(this);

  CachedWatcher<double?> cachedWatcher(String key) =>
      DoubleCachedWatcherNullable(
        this,
        key,
      );
}

/// IntWatcherExNullable
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable integer values.
extension IntWatcherExNullable on int? {
  Watcher<int?> get watcher => Watcher(this);

  CachedWatcher<int?> cachedWatcher(String key) => IntCachedWatcherNullable(
        this,
        key,
      );
}

/// DateTimeWatcherExNullable
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable DateTime objects.
extension DateTimeWatcherExNullable on DateTime? {
  Watcher<DateTime?> get watcher => Watcher(this);

  CachedWatcher<DateTime?> cachedWatcher(String key) =>
      DateTimeCachedWatcherNullable(this, key);
}

/// StringWatcherExNullable
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable String values.
extension StringWatcherExNullable on String? {
  Watcher<String?> get watcher => Watcher(this);

  CachedWatcher<String?> cachedWatcher(String key) =>
      StringCachedWatcherNullable(
        this,
        key,
      );
}

/// ColorWatcherExNullable
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable Color objects.
extension ColorWatcherExNullable on Color? {
  Watcher<Color?> get watcher => Watcher(this);

  CachedWatcher<Color?> cachedWatcher(String key) => ColorCachedWatcherNullable(
        this,
        key,
      );
}

/// UriWatcherExNullable
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable Uri objects.
extension UriWatcherExNullable on Uri? {
  Watcher<Uri?> get watcher => Watcher(this);

  CachedWatcher<Uri?> cachedWatcher(String key) => UriCachedWatcherNullable(
        this,
        key,
      );
}

/// ListWatcherExNullable<T>
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable List<T> objects.
extension ListWatcherExNullable<T> on List<T>? {
  Watcher<List<T>?> get watcher => Watcher(this);

  CachedWatcher<List<T>?> cachedWatcher(String key) =>
      ListCachedWatcherNullable(
        this,
        key,
      );
}

/// MapWatcherExNullable<K, V>
///
/// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable Map<K, V> objects.
extension MapWatcherExNullable<K, V> on Map<K, V>? {
  Watcher<Map<K, V>?> get watcher => Watcher(this);

  CachedWatcher<Map<K, V>?> cachedWatcher(String key) =>
      MapCachedWatcherNullable(
        this,
        key,
      );
}
