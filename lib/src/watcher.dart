// For Boolean
import 'package:flutter/material.dart';

class Watcher<T> extends ValueNotifier<T> {
  Watcher(super.initial);

  /// gets the previous value of the [Watcher].
  late T prevValue = value;

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
  BoolWatcher(super.initial);
}

// For Double
class DoubleWatcher extends Watcher<double> {
  DoubleWatcher(super.initial);

  @override
  String toString() => value.toStringAsFixed(2);
}

// For Integer
class IntWatcher extends Watcher<int> {
  IntWatcher(super.initial);
}

// For Num (covers both int and double)
class NumWatcher extends Watcher<num> {
  NumWatcher(super.initial);
}

// For String
class StringWatcher extends Watcher<String> {
  StringWatcher(super.initial);

  @override
  String toString() => value;
}

// For Color
class ColorWatcher extends Watcher<Color> {
  ColorWatcher(super.initial);
}

// For Uri
class UriWatcher extends Watcher<Uri> {
  UriWatcher(super.initial);
}

// For Generic List<T>
class ListWatcher<T> extends Watcher<List<T>> {
  ListWatcher(super.initial);
}

// For Generic Iterable<T>
class IterableWatcher<E> extends Watcher<Iterable<E>> {
  IterableWatcher(super.initial);
}

// For Generic Map<K, V>
class MapWatcher<K, V> extends Watcher<Map<K, V>> {
  MapWatcher(super.initial);
}

// For Duration

class DurationWatcher extends Watcher<Duration> {
  DurationWatcher(super.initial);
}
