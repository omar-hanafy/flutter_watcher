// For Boolean
import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

class Watcher<T> extends ValueNotifier<T> {
  Watcher(super.initial, {this.safeMode = true});

  /// safeMode if enabled will not allow any setting of value or notifying any listeners if the Watcher [isDisposed]
  final bool safeMode;

  /// gets the previous value of the [Watcher].
  T? prevValue;

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
    prevValue = value;
    super.value = newValue;
  }

  @override
  set value(T newValue) {
    if (isDisposed && safeMode) return;
    prevValue = value;
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

  R updateOnAction<R>(R Function() action, {bool forceRefresh = true}) {
    final current = v;
    final a = action();
    if (isEqual(current, v)) {
      prevValue = current;
      notifyListeners();
    } else if (forceRefresh) {
      notifyListeners();
    }
    return a;
  }
}

/// allows to quickly create a Watcher of type bool.
class BoolWatcher extends Watcher<bool> {
  BoolWatcher(super.initial);
}

/// allows to quickly create a Watcher of type double.
class DoubleWatcher extends Watcher<double> {
  DoubleWatcher(super.initial);

  @override
  String toString() => value.toStringAsFixed(2);
}

/// allows to quickly create a Watcher of type int.
class IntWatcher extends Watcher<int> {
  IntWatcher(super.initial);
}

/// allows to quickly create a Watcher of type num.
class NumWatcher extends Watcher<num> {
  NumWatcher(super.initial);
}

/// allows to quickly create a Watcher of type String.
class StringWatcher extends Watcher<String> {
  StringWatcher(super.initial);

  @override
  String toString() => value;
}

/// allows to quickly create a Watcher of type Color.
class ColorWatcher extends Watcher<Color> {
  ColorWatcher(super.initial);
}

/// allows to quickly create a Watcher of type Uri.
class UriWatcher extends Watcher<Uri> {
  UriWatcher(super.initial);
}

/// allows to quickly create a Watcher of type List<T>.
class ListWatcher<T> extends Watcher<List<T>> {
  ListWatcher(super.initial);
}

/// allows to quickly create a Watcher of type Iterable<E>.
class IterableWatcher<E> extends Watcher<Iterable<E>> {
  IterableWatcher(super.initial);
}

/// allows to quickly create a Watcher of type Map<K, V>.
class MapWatcher<K, V> extends Watcher<Map<K, V>> {
  MapWatcher(super.initial);
}

/// allows to quickly create a Watcher of type Duration.
class DurationWatcher extends Watcher<Duration> {
  DurationWatcher(super.initial);
}
