import 'dart:async';

import 'package:flutter/material.dart';

/// Extension on `ValueNotifier<T>` to provide additional functionalities.
extension ValueNotifierEx<T> on ValueNotifier<T> {
  /// Updates the `ValueNotifier`'s value to [newValue] if [condition] returns true.
  ///
  /// Example:
  /// ```dart
  /// final counter = 0.watcher;
  /// counter.updateIf((val) => val < 10, 10);
  /// // This will set the counter's value to 10 if it's currently less than 10.
  /// ```
  void updateIf(bool Function(T) condition, T newValue) {
    if (condition(value)) {
      value = newValue;
    }
  }

  /// Registers a callback to be invoked whenever the `ValueNotifier`'s value changes.
  ///
  /// Example:
  /// ```dart
  /// final counter = 0.watcher;
  /// final unsubscribe = counter.onChange((val) {
  ///   print("Counter changed: $val");
  /// });
  /// // Later when you want to stop listening to changes
  /// unsubscribe();
  /// ```
  VoidCallback onChange(void Function(T value) action) {
    void listener() => action(value);
    addListener(listener);

    return () => removeListener(listener);
  }

  /// Registers a debounced callback which is invoked only after the notifier's value
  /// is stable for the specified [duration].
  ///
  /// Example:
  /// ```dart
  /// final searchInput = "".watcher;
  /// final unsubscribe = searchInput.debounce(Duration(seconds: 1), (val) {
  ///   print("Search for: $val");
  /// });
  /// // Debounce the search input, only triggers the print after 1 second of stability in input.
  /// // To stop listening to the debounced changes
  /// unsubscribe();
  /// ```
  VoidCallback debounce(Duration duration, void Function(T value) action) {
    Timer? debounceTimer;

    void listener() {
      debounceTimer?.cancel();
      debounceTimer = Timer(duration, () => action(value));
    }

    addListener(listener);

    return () => {
          debounceTimer?.cancel(),
          removeListener(listener),
        };
  }
}
