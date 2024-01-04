import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

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
/// final myValue = ValueNotifier<int>(0);
/// myValue.increment(); // Increments the value in the notifier
///
/// These extensions cover various data types, offering tailored methods for each, such
/// as [increment()] for numeric types, [toggle()] for booleans, and more. This file is
/// part of the flutter_watcher package, which focuses on providing user-friendly
/// solutions for state management in Flutter.
extension ValueNotifierEx<T> on ValueNotifier<T> {
  /// Update value if it meets a condition
  void updateIf(bool Function(T) condition, T newValue) {
    if (condition(value)) {
      value = newValue;
    }
  }

  /// Perform an action on value change and return a function to remove the listener
  VoidCallback onChange(void Function(T value) action) {
    void listener() => action(value);
    addListener(listener);

    /// Return a function that removes the listener
    return () => removeListener(listener);
  }

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

// Transform the current value to another type
  ValueNotifier<R> map<R>(R Function(T) transform) {
    final result = ValueNotifier<R>(transform(value));
    addListener(() {
      result.value = transform(value);
    });
    return result;
  }

// Combine with another ValueNotifier
  ValueNotifier<R> combineWith<U, R>(
    ValueNotifier<U> other,
    R Function(T, U) combine,
  ) {
    final combined = ValueNotifier<R>(combine(value, other.value));
    void update() => combined.value = combine(value, other.value);
    addListener(update);
    other.addListener(update);
    return combined;
  }
}

/// BoolValueNotifierEx
///
/// Extension on `ValueNotifier<bool>` providing additional boolean-specific functionalities.
/// This extension simplifies toggling and other boolean operations directly on the notifier.
///
/// Example:
/// ```dart
/// final myBoolNotifier = ValueNotifier<bool>(true);
/// myBoolNotifier.toggle(); // Toggles the boolean value.
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
}

/// IterableValueNotifierEx
///
/// Extension on `ValueNotifier<Iterable<T>>` for enhancing iterable operations.
/// It provides easy-to-use methods for modifying and handling iterable data types.
///
/// Example:
/// ```dart
/// final myIterableNotifier = ValueNotifier<Iterable<int>>([1, 2, 3]);
/// // Perform operations like add, remove, etc., directly on the iterable notifier.
/// ```
extension IterableValueNotifierEx<T> on ValueNotifier<Iterable<T>> {
  /// documentation is available in the original API of the action used in [value]
  Iterator<T> get iterator => value.iterator;

  /// documentation is available in the original API of the action used in [value]
  bool contains(Object? value) => this.value.contains(value);

  /// documentation is available in the original API of the action used in [value]
  bool add(T value) => this.value.toSet().add(value);

  /// documentation is available in the original API of the action used in [value]
  void addAll(Iterable<T> elements) => value = [...value, ...elements];

  /// documentation is available in the original API of the action used in [value]
  bool remove(Object? value) {
    final updatedValue = this.value.toSet()..remove(value);
    this.value = updatedValue;
    return updatedValue.contains(value);
  }

  /// documentation is available in the original API of the action used in [value]
  T? lookup(Object? object) {
    for (final element in value) {
      if (element == object) return element;
    }
    return null;
  }

  /// documentation is available in the original API of the action used in [value]
  void removeAll(Iterable<Object?> elements) {
    final updatedValue = value.toSet()..removeAll(elements);
    value = updatedValue;
  }

  /// documentation is available in the original API of the action used in [value]
  void retainAll(Iterable<Object?> elements) {
    final updatedValue = value.toSet()..retainAll(elements);
    value = updatedValue;
  }

  /// documentation is available in the original API of the action used in [value]
  void removeWhere(bool Function(T element) test) {
    final updatedValue = value.where((element) => !test(element)).toList();
    value = updatedValue;
  }

  /// documentation is available in the original API of the action used in [value]
  void retainWhere(bool Function(T element) test) {
    final updatedValue = value.where((element) => test(element)).toList();
    value = updatedValue;
  }

  /// documentation is available in the original API of the action used in [value]
  bool containsAll(Iterable<Object?> other) => value.toSet().containsAll(other);

  /// documentation is available in the original API of the action used in [value]
  Set<T> intersection(Set<Object?> other) => value.toSet().intersection(other);

  /// documentation is available in the original API of the action used in [value]
  Set<T> union(Set<T> other) => value.toSet().union(other);

  /// documentation is available in the original API of the action used in [value]
  Set<T> difference(Set<Object?> other) => value.toSet().difference(other);

  /// documentation is available in the original API of the action used in [value]
  void clear() => value = [];

  /// documentation is available in the original API of the action used in [value]
  Set<T> toSet() => value.toSet();
}

/// ListValueNotifierEx
///
/// Extension on `ValueNotifier<List<E>>` offering convenient list manipulation methods.
/// This extension enables direct operations like add, remove, and clear on the list notifier.
///
/// Example:
/// ```dart
/// final myListNotifier = ValueNotifier<List<int>>([1, 2, 3]);
/// myListNotifier.add(4); // Adds 4 to the list.
/// ```
extension ListValueNotifierEx<E> on ValueNotifier<List<E>> {
  /// documentation is available in the original API of the action used in [value]
  void add(E item) {
    value = List.from(value)..add(item);
  }

  /// documentation is available in the original API of the action used in [value]
  void addAll(Iterable<E> items) {
    value = List.from(value)..addAll(items);
  }

  /// documentation is available in the original API of the action used in [value]
  void remove(E item) {
    value = List.from(value)..remove(item);
  }

  /// documentation is available in the original API of the action used in [value]
  void clear() {
    value = List.from(value)..clear();
  }

  /// documentation is available in the original API of the action used in [value]
  E operator [](int index) => value[index];

  /// documentation is available in the original API of the action used in [value]
  void operator []=(int index, E value) => this.value[index] = value;

  /// documentation is available in the original API of the action used in [value]
  set first(E value) => this.value.first = value;

  /// documentation is available in the original API of the action used in [value]
  set last(E value) => this.value.last = value;

  /// documentation is available in the original API of the action used in [value]
  /// documentation is available in the original API of the action used in [value]
  int get length => value.length;

  /// documentation is available in the original API of the action used in [value]
  set length(int newLength) => value.length = newLength;

  /// documentation is available in the original API of the action used in [value]
  /// documentation is available in the original API of the action used in [value]
  Iterable<E> get reversed => value.reversed;

  /// documentation is available in the original API of the action used in [value]
  void sort([int Function(E a, E b)? compare]) => value.sort(compare);

  /// documentation is available in the original API of the action used in [value]
  void shuffle([Random? random]) => value.shuffle(random);

  /// documentation is available in the original API of the action used in [value]
  int indexOf(E element, [int start = 0]) => value.indexOf(element, start);

  /// documentation is available in the original API of the action used in [value]
  int indexWhere(bool Function(E element) test, [int start = 0]) =>
      value.indexWhere(test, start);

  /// documentation is available in the original API of the action used in [value]
  int lastIndexWhere(bool Function(E element) test, [int? start]) =>
      value.lastIndexWhere(test, start);

  /// documentation is available in the original API of the action used in [value]
  int lastIndexOf(E element, [int? start]) => value.lastIndexOf(element, start);

  /// documentation is available in the original API of the action used in [value]
  void insert(int index, E element) => value.insert(index, element);

  /// documentation is available in the original API of the action used in [value]
  void insertAll(int index, Iterable<E> iterable) =>
      value.insertAll(index, iterable);

  /// documentation is available in the original API of the action used in [value]
  void setAll(int index, Iterable<E> iterable) => value.setAll(index, iterable);

  /// documentation is available in the original API of the action used in [value]
  E removeAt(int index) => value.removeAt(index);

  /// documentation is available in the original API of the action used in [value]
  E removeLast() => value.removeLast();

  /// documentation is available in the original API of the action used in [value]
  void removeWhere(bool Function(E element) test) => value.removeWhere(test);

  /// documentation is available in the original API of the action used in [value]
  void retainWhere(bool Function(E element) test) => value.retainWhere(test);

  /// documentation is available in the original API of the action used in [value]
  List<E> operator +(List<E> other) => value + other;

  /// documentation is available in the original API of the action used in [value]
  List<E> sublist(int start, [int? end]) => value.sublist(start, end);

  /// documentation is available in the original API of the action used in [value]
  Iterable<E> getRange(int start, int end) => value.getRange(start, end);

  /// documentation is available in the original API of the action used in [value]
  void setRange(int start, int end, Iterable<E> iterable,
          [int skipCount = 0]) =>
      value.setRange(start, end, iterable, skipCount);

  /// documentation is available in the original API of the action used in [value]
  void removeRange(int start, int end) => value.removeRange(start, end);

  /// documentation is available in the original API of the action used in [value]
  void fillRange(int start, int end, [E? fillValue]) =>
      value.fillRange(start, end, fillValue);

  /// documentation is available in the original API of the action used in [value]
  void replaceRange(int start, int end, Iterable<E> replacements) =>
      value.replaceRange(start, end, replacements);

  /// documentation is available in the original API of the action used in [value]
  Map<int, E> asMap() => value.asMap();

  /// documentation is available in the original API of the action used in [value]
  bool get isEmpty => value.isEmpty;

  /// documentation is available in the original API of the action used in [value]
  bool get isEmptyOrNull => value.isEmptyOrNull;

  /// documentation is available in the original API of the action used in [value]
  bool get isNotEmptyOrNull => value.isNotEmptyOrNull;
}

/// SetValueNotifierEx
///
/// Extension on `ValueNotifier<Set<T>>` for set-specific operations.
/// It allows direct manipulation of sets like adding or removing elements.
///
/// Example:
/// ```dart
/// final mySetNotifier = ValueNotifier<Set<int>>({1, 2, 3});
/// mySetNotifier.add(4); // Adds 4 to the set.
/// ```
extension SetValueNotifierEx<T> on ValueNotifier<Set<T>> {
  /// documentation is available in the original API of the action used in [value]
  void add(T item) {
    value = Set.from(value)..add(item);
  }

  /// documentation is available in the original API of the action used in [value]
  void addAll(Iterable<T> items) {
    value = Set.from(value)..addAll(items);
  }

  /// documentation is available in the original API of the action used in [value]
  void remove(T item) {
    value = Set.from(value)..remove(item);
  }

  /// documentation is available in the original API of the action used in [value]
  void clear() {
    value = Set.from(value)..clear();
  }
}

/// MapValueNotifierEx
///
/// Extension on `ValueNotifier<Map<K, V>>` providing enhanced map handling capabilities.
/// It simplifies operations like adding or removing key-value pairs in the map notifier.
///
/// Example:
/// ```dart
/// final myMapNotifier = ValueNotifier<Map<String, int>>({'key1': 1});
/// myMapNotifier['key2'] = 2; // Adds 'key2': 2 to the map.
/// ```
extension MapValueNotifierEx<K, V> on ValueNotifier<Map<K, V>> {
  /// Adds all key-value pairs from the provided map.
  void addAll(Map<K, V> other) => value.addAll(other);

  /// Removes all key-value pairs from the map.
  void clear() => value.clear();

  /// Returns an iterable of all keys in the map.
  /// documentation is available in the original API of the action used in [value]
  Iterable<K> get keys => value.keys;

  /// Returns an iterable of all values in the map.
  /// documentation is available in the original API of the action used in [value]
  Iterable<V> get values => value.values;

  /// Removes the key and its associated value from the map and returns the value.
  V? remove(Object? key) => value.remove(key);

  /// Checks if the map contains the specified key.
  bool containsKey(Object? key) => value.containsKey(key);

  /// Returns the value associated with the given key, or a default value if the key is not found.
  V? operator [](Object? key) => value[key];

  /// Associates a key with a value in the map.
  void operator []=(K key, V value) => this.value[key] = value;

  /// Adds all the key-value pairs of the provided map to this map.
  void addEntries(Iterable<MapEntry<K, V>> newEntries) =>
      value.addEntries(newEntries);

  /// documentation is available in the original API of the action used in [value]
  Iterable<MapEntry<K, V>> get entries => value.entries;

  /// documentation is available in the original API of the action used in [value]
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) =>
      value.map<K2, V2>(convert);

  /// documentation is available in the original API of the action used in [value]
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) =>
      value.update(key, update, ifAbsent: ifAbsent);

  /// documentation is available in the original API of the action used in [value]
  void updateAll(V Function(K key, V value) update) => value.updateAll(update);

  /// documentation is available in the original API of the action used in [value]
  void removeWhere(bool Function(K key, V value) test) =>
      value.removeWhere(test);

  /// documentation is available in the original API of the action used in [value]
  V putIfAbsent(K key, V Function() ifAbsent) =>
      value.putIfAbsent(key, ifAbsent);

  /// documentation is available in the original API of the action used in [value]
  void forEach(void Function(K key, V value) action) => value.forEach(action);

  /// documentation is available in the original API of the action used in [value]
  int get length => value.length;

  /// documentation is available in the original API of the action used in [value]
  bool get isEmpty => value.isEmpty;

  /// documentation is available in the original API of the action used in [value]
  bool get isNotEmpty => value.isNotEmpty;
}

/// NumericValueNotifierEx
///
/// Extension on `ValueNotifier<num>` for numeric operations.
/// It includes methods for incrementing and decrementing numeric values in the notifier.
///
/// Example:
/// ```dart
/// final myNumNotifier = ValueNotifier<num>(10);
/// myNumNotifier.increment(); // Increments the numeric value.
/// ```
extension NumericValueNotifierEx on ValueNotifier<num> {
  /// Increment the value by a given step (default is 1).
  void increment([num step = 1]) {
    value += step;
  }

  /// reset the value of the [Watcher]
  void reset() => value = 0;

  /// Decrement the value by a given step (default is 1).
  void decrement([num step = 1]) {
    value -= step;
  }

  /// Multiply the value by a given factor.
  void multiply(num factor) {
    value *= factor;
  }

  /// Divide the value by a given divisor. Avoid division by zero.
  void divide(num divisor) {
    if (divisor != 0) {
      value /= divisor;
    }
  }

  /// Modulo operation with a given divisor. Avoid division by zero.
  void modulo(num divisor) {
    if (divisor != 0) {
      value %= divisor;
    }
  }

  /// Negate the value (change its sign).
  void negate() {
    value = -value;
  }

  /// Absolute value (make the value non-negative).
  void abs() {
    value = value.abs();
  }

  /// Minimum of the value and another num.
  void min(num other) {
    value = value < other ? value : other;
  }

  /// Maximum of the value and another num.
  void max(num other) {
    value = value > other ? value : other;
  }

  /// Round the value to the nearest integer.
  void round() {
    value = value.round();
  }

  /// Floor the value (round down to the nearest integer).
  void floor() {
    value = value.floor();
  }

  /// Ceiling the value (round up to the nearest integer).
  void ceil() {
    value = value.ceil();
  }

  /// documentation is available in the original API of the action used in [value]
  int compareTo(num other) => value.compareTo(other);

  /// documentation is available in the original API of the action used in [value]
  num operator +(num other) => value + other;

  /// documentation is available in the original API of the action used in [value]
  num operator -(num other) => value - other;

  /// documentation is available in the original API of the action used in [value]
  num operator *(num other) => value * other;

  /// documentation is available in the original API of the action used in [value]
  num operator %(num other) => value % other;

  /// documentation is available in the original API of the action used in [value]
  double operator /(num other) => value / other;

  /// documentation is available in the original API of the action used in [value]
  int operator ~/(num other) => value ~/ other;

  /// documentation is available in the original API of the action used in [value]
  num operator -() => -value;

  /// documentation is available in the original API of the action used in [value]
  num remainder(num other) => value.remainder(other);

  /// documentation is available in the original API of the action used in [value]
  bool operator <(num other) => value < other;

  /// documentation is available in the original API of the action used in [value]
  bool operator <=(num other) => value <= other;

  /// documentation is available in the original API of the action used in [value]
  bool operator >(num other) => value > other;

  /// documentation is available in the original API of the action used in [value]
  bool operator >=(num other) => value >= other;

  /// documentation is available in the original API of the action used in [value]
  /// documentation is available in the original API of the action used in [value]
  bool get isNaN => value.isNaN;

  /// documentation is available in the original API of the action used in [value]
  /// documentation is available in the original API of the action used in [value]
  bool get isNegative => value.isNegative;

  /// documentation is available in the original API of the action used in [value]
  /// documentation is available in the original API of the action used in [value]
  bool get isInfinite => value.isInfinite;

  /// documentation is available in the original API of the action used in [value]
  /// documentation is available in the original API of the action used in [value]
  bool get isFinite => value.isFinite;

  /// documentation is available in the original API of the action used in [value]
  /// documentation is available in the original API of the action used in [value]
  num get sign => value.sign;

  /// documentation is available in the original API of the action used in [value]
  int truncate() {
    value = value.truncate();
    return value.toInt();
  }

  /// documentation is available in the original API of the action used in [value]
  double roundToDouble() {
    value = value.roundToDouble();
    return value.toDouble();
  }

  /// documentation is available in the original API of the action used in [value]
  double floorToDouble() {
    value = value.floorToDouble();
    return value.toDouble();
  }

  /// documentation is available in the original API of the action used in [value]
  double ceilToDouble() {
    value = value.ceilToDouble();
    return value.toDouble();
  }

  /// documentation is available in the original API of the action used in [value]
  double truncateToDouble() {
    value = value.truncateToDouble();
    return value.toDouble();
  }

  /// documentation is available in the original API of the action used in [value]
  num clamp(num lowerLimit, num upperLimit) =>
      value.clamp(lowerLimit, upperLimit);

  /// documentation is available in the original API of the action used in [value]
  int toInt() {
    value = value.toInt();
    return value.toInt();
  }

  /// documentation is available in the original API of the action used in [value]
  double toDouble() {
    value = value.toDouble();
    return value.toDouble();
  }

  /// documentation is available in the original API of the action used in [value]
  String toStringAsFixed(int fractionDigits) =>
      value.toStringAsFixed(fractionDigits);

  /// documentation is available in the original API of the action used in [value]
  String toStringAsExponential([int? fractionDigits]) =>
      value.toStringAsExponential(fractionDigits);

  /// documentation is available in the original API of the action used in [value]
  String toStringAsPrecision(int precision) =>
      value.toStringAsPrecision(precision);
}

/// UriValueNotifierEx
///
/// Extension on `ValueNotifier<Uri>` to facilitate URI manipulations.
/// It allows operations like updating the path of the URI directly on the notifier.
///
/// Example:
/// ```dart
/// final myUriNotifier = ValueNotifier<Uri>(Uri.parse('https://example.com'));
/// myUriNotifier.updatePath('/newpath'); // Updates the URI path.
/// ```
extension UriValueNotifierEx on ValueNotifier<Uri> {
  /// documentation is available in the original API of the action used in [value]
  String get scheme => value.scheme;

  /// documentation is available in the original API of the action used in [value]
  String get authority => value.authority;

  /// documentation is available in the original API of the action used in [value]
  String get userInfo => value.userInfo;

  /// documentation is available in the original API of the action used in [value]
  String get host => value.host;

  /// documentation is available in the original API of the action used in [value]
  int get port => value.port;

  /// documentation is available in the original API of the action used in [value]
  String get path => value.path;

  /// documentation is available in the original API of the action used in [value]
  String get query => value.query;

  /// documentation is available in the original API of the action used in [value]
  String get fragment => value.fragment;

  /// documentation is available in the original API of the action used in [value]
  List<String> get pathSegments => value.pathSegments;

  /// documentation is available in the original API of the action used in [value]
  Map<String, String> get queryParameters => value.queryParameters;

  /// documentation is available in the original API of the action used in [value]
  Map<String, List<String>> get queryParametersAll => value.queryParametersAll;

  /// documentation is available in the original API of the action used in [value]
  bool get isAbsolute => value.isAbsolute;

  /// documentation is available in the original API of the action used in [value]
  bool get hasScheme => value.hasScheme;

  /// documentation is available in the original API of the action used in [value]
  bool get hasAuthority => value.hasAuthority;

  /// documentation is available in the original API of the action used in [value]
  bool get hasPort => value.hasPort;

  /// documentation is available in the original API of the action used in [value]
  bool get hasQuery => value.hasQuery;

  /// documentation is available in the original API of the action used in [value]
  bool get hasFragment => value.hasFragment;

  /// documentation is available in the original API of the action used in [value]
  bool get hasEmptyPath => value.hasEmptyPath;

  /// documentation is available in the original API of the action used in [value]
  bool get hasAbsolutePath => value.hasAbsolutePath;

  /// documentation is available in the original API of the action used in [value]
  String get origin => value.origin;

  bool isScheme(String scheme) => value.isScheme(scheme);

  /// documentation is available in the original API of the action used in [value]
  UriData? get data => value.data;

  /// documentation is available in the original API of the action used in [value]
  Uri replace({
    String? scheme,
    String? userInfo,
    String? host,
    int? port,
    String? path,
    Iterable<String>? pathSegments,
    String? query,
    Map<String, dynamic /*String?|Iterable<String>*/ >? queryParameters,
    String? fragment,
  }) {
    return value.replace(
      scheme: scheme,
      userInfo: userInfo,
      host: host,
      port: port,
      path: path,
      pathSegments: pathSegments,
      query: query,
      queryParameters: queryParameters,
      fragment: fragment,
    );
  }

  /// documentation is available in the original API of the action used in [value]
  Uri removeFragment() => value.removeFragment();

  /// documentation is available in the original API of the action used in [value]
  Uri resolve(String reference) => value.resolve(reference);

  /// documentation is available in the original API of the action used in [value]
  Uri resolveUri(Uri reference) => value.resolveUri(reference);

  /// documentation is available in the original API of the action used in [value]
  Uri normalizePath() => value.normalizePath();
}
