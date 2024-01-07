import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// BoolValueNotifierEx
///
/// Extension on `ValueNotifier<bool>` providing additional boolean-specific functionalities.
/// This extension simplifies toggling and other boolean operations directly on the notifier.
///
/// Example:
/// ```dart
/// final boolWatcher = true.watcher;
/// boolWatcher.toggle(); // Toggles the boolean value.
/// ```
extension BoolValueNotifierEx on ValueNotifier<bool> {
  /// toggle the value of the [Watcher]
  void toggle() => value = !value;

  /// toggle the value of the [Watcher] and run the provided function.
  void toggleWithCallback(VoidCallback callback) {
    toggle();
    callback();
  }

  /// toggle after a specific time.
  Future<void> delayedToggle(Duration delay) async {
    await delay.delayed<void>();
    toggle();
  }

  /// toggle the value of the Watcher based on a condition.
  void conditionalToggle({required bool condition}) {
    if (condition) toggle();
  }

  /// make the value of the [Watcher] true
  void setTrue() => value = true;

  /// make the value of the [Watcher] false
  void setFalse() => value = false;

  /// The logical conjunction ("and") of this and [other].
  ///
  /// Returns `true` if both this and [other] are `true`, and `false` otherwise.
  bool operator &(bool other) => value & other;

  /// The logical disjunction ("inclusive or") of this and [other].
  ///
  /// Returns `true` if either this or [other] is `true`, and `false` otherwise.)
  bool operator |(bool other) => value | other;

  /// The logical exclusive disjunction ("exclusive or") of this and [other].
  ///
  /// Returns whether this and [other] are neither both `true` nor both `false`.
  bool operator ^(bool other) => value ^ other;
}