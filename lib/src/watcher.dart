import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

class Watcher<T> extends ValueNotifier<T> {
  Watcher(super.initial, {this.safeMode = true});

  /// safeMode if enabled will not allow any setting of value or notifying any listeners if the Watcher [isDisposed]
  final bool safeMode;

  /// flag which indicates if you called the [dispose] method in this instance before or not.
  /// it is useful when you want to safely do some operations on the [Watcher] without getting exception if it gets disposed.
  bool isDisposed = false;

  /// rebuilds and trigger any listeners of any [ValueWatch] or [watch] attached to that [Watcher].
  void refresh() => notifyListeners();

  @override
  void notifyListeners() {
    if (isDisposed && safeMode) return;
    super.notifyListeners();
  }

  /// gets the current value of the [Watcher].
  T get v => value;

  set v(T newValue) {
    if (isDisposed && safeMode) return;
    super.value = newValue;
  }

  @override
  set value(T newValue) {
    if (isDisposed && safeMode) return;
    super.value = newValue;
  }

  @override
  void dispose() {
    if (isDisposed && safeMode) return;
    isDisposed = true;
    super.dispose();
  }

  @override
  String toString() => value.toString();

  R updateOnAction<R>(R Function() action) {
    final a = action();
    notifyListeners();
    return a;
  }
}
