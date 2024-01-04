// For Boolean
import 'package:flutter/material.dart';

class Watcher<T> extends ValueNotifier<T> {
  Watcher(super.initial);

  /// gets the previous value of the [Watcher].
  late T prevValue = value;

  /// rebuilds and trigger any listeners of any [ValueWatch] or [watch] attached to that [Watcher].
  void refresh() {
    notifyListeners();
  }

  /// gets the current value of the [Watcher].
  T get v => value;

  set v(T newValue) {
    prevValue = value;
    super.value = newValue;
  }

  @override
  set value(T newValue) {
    prevValue = value;
    super.value = newValue;
  }

  @override
  String toString() => value.toString();
}

class BoolWatcher extends Watcher<bool> {
  /// allows to quickly create a Watcher of type bool.
  BoolWatcher(super.initial);
}

class DoubleWatcher extends Watcher<double> {
  /// allows to quickly create a Watcher of type double.
  DoubleWatcher(super.initial);

  @override
  String toString() => value.toStringAsFixed(2);
}

class IntWatcher extends Watcher<int> {
  /// allows to quickly create a Watcher of type int.
  IntWatcher(super.initial);
}

class NumWatcher extends Watcher<num> {
  /// allows to quickly create a Watcher of type num.
  NumWatcher(super.initial);
}

class StringWatcher extends Watcher<String> {
  /// allows to quickly create a Watcher of type String.
  StringWatcher(super.initial);

  @override
  String toString() => value;
}

class ColorWatcher extends Watcher<Color> {
  /// allows to quickly create a Watcher of type Color.
  ColorWatcher(super.initial);
}

class UriWatcher extends Watcher<Uri> {
  /// allows to quickly create a Watcher of type Uri.
  UriWatcher(super.initial);
}

class ListWatcher<T> extends Watcher<List<T>> {
  /// allows to quickly create a Watcher of type List<T>.
  ListWatcher(super.initial);
}

class IterableWatcher<E> extends Watcher<Iterable<E>> {
  /// allows to quickly create a Watcher of type Iterable<E>.
  IterableWatcher(super.initial);
}

class MapWatcher<K, V> extends Watcher<Map<K, V>> {
  /// allows to quickly create a Watcher of type Map<K, V>.
  MapWatcher(super.initial);
}

class DurationWatcher extends Watcher<Duration> {
  /// allows to quickly create a Watcher of type Duration.
  DurationWatcher(super.initial);
}
