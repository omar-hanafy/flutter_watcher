import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// extension on [T] where [T] is any non-nullable [Object],
/// Its used to directly make [Watcher] instance from that [T].
extension WatchExtension<T extends Object> on T {
  /// using .watcher on any [Objects] allows you to create an instance of [Watcher] that holds a value of type [T]
  /// for example:
  /// ```dart
  /// // creates Watcher<User>(User()) where user is your custom type/class.
  /// final userWatcher = User().watcher;
  /// ```
  Watcher<T> get watcher => Watcher<T>(this);
}

/// BoolWatcherEx
///
/// Extension on boolean values to provide easy access to creating a [Watcher] and [CachedWatcher] for booleans.
extension BoolWatcherEx on bool {
  /// directly make [Watcher] instance from [bool].
  BoolWatcher get watcher => BoolWatcher(this);

  /// directly make [CachedWatcher] instance from [bool].
  BoolCachedWatcher cachedWatcher(String key) => BoolCachedWatcher(
        this,
        key,
      );
}

/// NumWatcherEx
///
/// Extension on numeric values to provide easy access to creating a [Watcher] and [CachedWatcher] for numeric types.
extension NumWatcherEx on num {
  /// directly make [Watcher] instance from [num].
  NumWatcher get watcher => NumWatcher(this);

  /// directly make [CachedWatcher] instance from [num].
  NumCachedWatcher cachedWatcher(String key) => NumCachedWatcher(
        this,
        key,
      );
}

/// DoubleWatcherEx
///
/// Extension on double values to provide easy access to creating a [Watcher] and [CachedWatcher] for double types.
extension DoubleWatcherEx on double {
  /// directly make [Watcher] instance from [double].
  DoubleWatcher get watcher => DoubleWatcher(this);

  /// directly make [CachedWatcher] instance from [double].
  DoubleCachedWatcher cachedWatcher(String key) => DoubleCachedWatcher(
        this,
        key,
      );
}

/// IntWatcherEx
///
/// Extension on integer values to provide easy access to creating a [Watcher] and [CachedWatcher] for integers.
extension IntWatcherEx on int {
  /// directly make [Watcher] instance from [int].
  IntWatcher get watcher => IntWatcher(this);

  /// directly make [CachedWatcher] instance from [int].
  IntCachedWatcher cachedWatcher(String key) => IntCachedWatcher(
        this,
        key,
      );
}

/// DateTimeWatcherEx
///
/// Extension on DateTime to provide easy access to creating a [Watcher] and [CachedWatcher] for DateTime objects.
extension DateTimeWatcherEx on DateTime {
  /// directly make [Watcher] instance from [DateTime].
  DateTimeWatcher get watcher => DateTimeWatcher(this);

  /// directly make [CachedWatcher] instance from [DateTime].
  DateTimeCachedWatcher cachedWatcher(String key) =>
      DateTimeCachedWatcher(this, key);
}

/// StringWatcherEx
///
/// Extension on String to provide easy access to creating a [Watcher] and [CachedWatcher] for String values.
extension StringWatcherEx on String {
  /// directly make [Watcher] instance from [String].
  StringWatcher get watcher => StringWatcher(this);

  /// directly make [CachedWatcher] instance from [String].
  StringCachedWatcher cachedWatcher(String key) => StringCachedWatcher(
        this,
        key,
      );
}

/// ColorWatcherEx
///
/// Extension on Color to provide easy access to creating a [Watcher] and [CachedWatcher] for Color objects.
extension ColorWatcherEx on Color {
  /// directly make [Watcher] instance from [Color].
  ColorWatcher get watcher => ColorWatcher(this);

  /// directly make [CachedWatcher] instance from [Color].
  ColorCachedWatcher cachedWatcher(String key) => ColorCachedWatcher(
        this,
        key,
      );
}

/// UriWatcherEx
///
/// Extension on Uri to provide easy access to creating a [Watcher] and [CachedWatcher] for Uri objects.
extension UriWatcherEx on Uri {
  /// directly make [Watcher] instance from [Uri].
  UriWatcher get watcher => UriWatcher(this);

  /// directly make [CachedWatcher] instance from [Uri].
  UriCachedWatcher cachedWatcher(String key) => UriCachedWatcher(
        this,
        key,
      );
}

/// ListWatcherEx<T>
///
/// Extension on List<T> to provide easy access to creating a [Watcher] and [CachedWatcher] for lists of any (primitive types)[https://dart.dev/language/built-in-types].
extension ListWatcherEx<E> on List<E> {
  /// directly make [Watcher] instance from [List].
  ListWatcher<E> get watcher => ListWatcher(this);

  /// directly make [CachedWatcher] instance from [List].
  ListCachedWatcher<E> cachedWatcher(String key) => ListCachedWatcher(
        this,
        key,
      );
}

/// ListWatcherEx<T>
///
/// Extension on List<T> to provide easy access to creating a [Watcher] and [CachedWatcher] for lists of any (primitive types)[https://dart.dev/language/built-in-types].
extension SetWatcherEx<E> on Set<E> {
  /// directly make [Watcher] instance from [List].
  SetWatcher<E> get watcher => SetWatcher(this);

  /// directly make [CachedWatcher] instance from [List].
  SetCachedWatcher<E> cachedWatcher(String key) => SetCachedWatcher(
        this,
        key,
      );
}

/// MapWatcherEx<K, V>
///
/// Extension on Map<K, V> to provide easy access to creating a [Watcher] and [CachedWatcher] for maps of any key-value (primitive types)[https://dart.dev/language/built-in-types].
extension MapWatcherEx<K, V> on Map<K, V> {
  /// directly make [Watcher] instance from [Map].
  MapWatcher<K, V> get watcher => MapWatcher(this);

  /// directly make [CachedWatcher] instance from [Map].
  MapCachedWatcher<K, V> cachedWatcher(String key) => MapCachedWatcher(
        this,
        key,
      );
}
//
// /// BoolWatcherExNullable
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable boolean values.
// extension BoolWatcherExNullable on bool? {
//   Watcher<bool?> get watcher => Watcher(this);
//
//   CachedWatcher<bool?> cachedWatcher(String key) => BoolNCachedWatcher(
//         key,
//         initialValue: this,
//       );
// }
//
// /// NumWatcherExNullable
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable numeric values.
// extension NumWatcherExNullable on num? {
//   Watcher<num?> get watcher => Watcher(this);
//
//   CachedWatcher<num?> cachedWatcher(String key) => NumNCachedWatcher(
//         key,
//         initialValue: this,
//       );
// }
//
// /// DoubleWatcherExNullable
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable double values.
// extension DoubleWatcherExNullable on double? {
//   Watcher<double?> get watcher => Watcher(this);
//
//   CachedWatcher<double?> cachedWatcher(String key) => DoubleNCachedWatcher(
//         key,
//         initialValue: this,
//       );
// }
//
// /// IntWatcherExNullable
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable integer values.
// extension IntWatcherExNullable on int? {
//   Watcher<int?> get watcher => Watcher(this);
//
//   CachedWatcher<int?> cachedWatcher(String key) => IntNCachedWatcher(
//         key,
//         initialValue: this,
//       );
// }
//
// /// StringWatcherExNullable
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable String values.
// extension StringWatcherExNullable on String? {
//   Watcher<String?> get watcher => Watcher(this);
//
//   CachedWatcher<String?> cachedWatcher(String key) => StringNCachedWatcher(
//         key,
//         initialValue: this,
//       );
// }
//
// /// ColorWatcherExNullable
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable Color objects.
// extension ColorWatcherExNullable on Color? {
//   Watcher<Color?> get watcher => Watcher(this);
//
//   CachedWatcher<Color?> cachedWatcher(String key) => ColorNCachedWatcher(
//         key,
//         initialValue: this,
//       );
// }
//
// /// UriWatcherExNullable
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable Uri objects.
// extension UriWatcherExNullable on Uri? {
//   Watcher<Uri?> get watcher => Watcher(this);
//
//   CachedWatcher<Uri?> cachedWatcher(String key) => UriNCachedWatcher(
//         key,
//         initialValue: this,
//       );
// }
//
// /// ListWatcherExNullable<T>
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable List<T> objects.
// extension ListWatcherExNullable<T> on List<T>? {
//   Watcher<List<T>?> get watcher => Watcher(this);
// }
//
// /// MapWatcherExNullable<K, V>
// ///
// /// Extension that provide easy access to create a [Watcher] and [CachedWatcher] for nullable Map<K, V> objects.
// extension MapWatcherExNullable<K, V> on Map<K, V>? {
//   Watcher<Map<K, V>?> get watcher => Watcher(this);
// }
