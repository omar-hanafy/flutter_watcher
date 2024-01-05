library;

/// Value Notifier Extensions
///
/// This file contains a collection of extensions for [ValueNotifier<T>] in Flutter.
/// These extensions are designed to enhance the usability of [ValueNotifier<T>] by
/// providing direct manipulation capabilities. The goal is to allow developers to work
/// with [ValueNotifier<T>] in a way that is both natural and concise, closely mirroring
/// the operations typically performed on the underlying data types.
///
/// Through these extensions, we enable more fluent and intuitive interactions with
/// [ValueNotifier<T>]. This approach simplifies the state management process in Flutter
/// applications by reducing boilerplate code and making the codebase more readable and
/// maintainable.
///
/// Example Usage:
///
/// final counter = 10.watcher;
/// counter.increment(2); // Increments the value in the notifier by 2 (defaults to 1).
///
/// These extensions cover various data types, offering tailored methods for each, such
/// as [increment()] for numeric types, [toggle()] for booleans, and more. This file is
/// part of the flutter_watcher package, which focuses on providing user-friendly
/// solutions for state management in Flutter.

export 'T_value_notifier_ex.dart';
export 'bool_value_notifier_ex.dart';
export 'double_value_notifier_ex.dart';
export 'int_value_notifier_ex.dart';
export 'iterable_value_notifier_ex.dart';
export 'map_value_notifier_ex.dart';
export 'numeric_value_notifier_ex.dart';
export 'uri_value_notifier_ex.dart';
