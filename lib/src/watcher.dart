import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// A [ChangeNotifier] that holds a single value.
///
/// When [value] is replaced with something that is not equal to the old
/// value as evaluated by the equality operator ==, this class notifies its
/// listeners.
///
/// When [safeMode] is enabled, and this [isDisposed], any [notifyListeners],
/// or setting new [value] will be ignored.
///
/// ## Limitations
///
/// Because this class only notifies listeners when the [value]'s _identity_
/// changes, listeners will not be notified when mutable state within the
/// value itself changes.
///
/// While there is custom watcher types that helps reusing this limitation
/// like [ListWatcher], [MapWatcher], [SetWatcher], etc,
/// When working with custom objects/types like changing variable inside your instance,
/// you need to manually using [refresh], or [notifyListeners].
///
/// As a result, this class is best used with only immutable data types.
///
/// For mutable data types, consider using the [watcher_classes]
/// or extending [ChangeNotifier] directly.
class Watcher<T> extends ChangeNotifier implements ValueListenable<T> {
  /// Creates a [ChangeNotifier] that wraps this value.
  Watcher(this._value, {this.safeMode = true}) {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  T _value;

  bool _isDisposed = false;

  /// safeMode if enabled will not allow any setting of value or notifying any listeners if the Watcher [isDisposed]
  final bool safeMode;

  /// The current value stored in this watcher.
  ///
  /// When the value is replaced with something that is not equal to the old
  /// value as evaluated by the equality operator ==, this class notifies its
  /// listeners.
  /// When this [isDisposed] and [safeMode] is true this class will ignore setting value or notifying any listeners.
  @override
  T get value => _value;

  /// Equivalent to the getter [value] but in shorter syntax.
  T get v => _value;

  /// Flag which returns true if you called the [dispose] method.
  /// It is useful when you want to safely do some operations on the [Watcher] without getting an exception if it gets disposed.
  bool get isDisposed => _isDisposed;

  set value(T newValue) {
    if ((_isDisposed && safeMode) || _value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  set v(T newValue) => value = newValue;

  void setWithoutNotify(T newValue) {
    if ((_isDisposed && safeMode) || _value == newValue) return;
    _value = newValue;
  }

  @override
  void dispose() {
    if (_isDisposed && safeMode) return;
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDisposed && safeMode) return;
    super.notifyListeners();
  }

  /// Rebuilds and trigger any listeners of any [WatchValue] or [watch] attached to that [Watcher].
  void refresh() => notifyListeners();

  @override
  String toString() => _value.toString();

  /// Will notifyListeners after a specific [action] has been made,
  /// and optionally return a result [R] of certain type.
  R updateOnAction<R>(R Function() action) {
    final result = action();
    notifyListeners();
    return result;
  }

  /// Updates the `ValueNotifier`'s value to [newValue] if [condition] returns true.
  void updateIf(bool Function(T) condition, T newValue) {
    if (condition(_value)) {
      value = newValue;
    }
  }

  /// Registers a callback to be invoked whenever the `ValueNotifier`'s value changes.
  VoidCallback onChange(void Function(T value) action) {
    void listener() => action(_value);
    addListener(listener);
    return () => removeListener(listener);
  }

  /// Registers a debounced callback which is invoked only after the notifier's value
  /// is stable for the specified [duration].
  VoidCallback debounce(Duration duration, void Function(T value) action) {
    Timer? debounceTimer;

    void listener() {
      debounceTimer?.cancel();
      debounceTimer = Timer(duration, () => action(_value));
    }

    addListener(listener);

    return () => {
          debounceTimer?.cancel(),
          removeListener(listener),
        };
  }

  /// Converts the [Watcher] into a [Stream]. This stream emits values whenever the
  /// [value] changes. The use of [distinct] ensures that consecutive duplicate values are
  /// filtered out, thus the stream only emits when the value actually changes.
  Stream<T> get stream =>
      Stream.periodic(Duration.zero, (_) => _value).distinct();
}
