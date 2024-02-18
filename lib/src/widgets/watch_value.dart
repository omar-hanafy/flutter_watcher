import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// WatchValue Widget
///
/// A widget that simplifies the integration and usage of [Watcher] instances within the Flutter UI.
/// It efficiently handles the rendering of widgets in response to state changes.
///
/// The [WatchValue] widget takes a [Watcher] instance and a builder function. The builder function
/// is responsible for returning the widget that should be rendered based on the current value of the [Watcher].
/// This setup ensures that the widget is automatically updated whenever the [Watcher]'s value changes,
/// making it highly efficient for creating reactive UI components.
///
/// The widget can be used directly with any [Watcher] instance, including those created via the [watch]
/// extension on various types, such as [bool], [int], [List], and more.
///
/// Usage:
/// ```dart
/// final isLoading = false.watcher;
///
/// @override
/// Widget build(BuildContext context) {
///   return WatchValue<bool>(
///     builder: (context, value) => MyWidget(value), // Builder function
///     watcher: isLoading, // Watcher instance
///   );
/// }
/// ```
///
/// Alternatively, the [watch] extension method can be used for a more concise syntax:
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return isLoading.watch(
///     (value) => MyWidget(value),
///   );
/// }
/// ```
///
/// [WatchValue] is an essential part of the flutter_watcher package, streamlining state management
/// in Flutter applications and facilitating the development of responsive and dynamic user interfaces.
class WatchValue<T> extends StatefulWidget {
  const WatchValue({
    required this.watcher,
    required this.builder,
    this.watchWhen,
    this.threshold,
    super.key,
  });

  /// [watcher]
  ///
  /// A [Watcher] instance that [WatchValue] listens to for changes.
  /// The widget updates whenever this watcher's value changes, triggering a rebuild of the widget
  /// returned by the [builder] function.
  ///
  /// This variable holds the state that the [WatchValue] widget will be observing.
  /// It's the core element that integrates the state management functionality of [Watcher]
  /// into the Flutter widget tree.
  final ValueListenable<T> watcher;

  /// [builder]
  ///
  /// A function that defines the widget to be built based on the current value of the [watcher].
  /// This function is called every time the [watcher]'s value changes and should return the widget
  /// that needs to be rendered for that value.
  ///
  /// The function provides the build context and the current value of the [watcher], offering
  /// the flexibility to design responsive and dynamic UI components that react to state changes.
  final Widget Function(BuildContext context, T value) builder;

  /// [watchWhen]
  ///
  /// An optional callback that determines whether or not the widget should rebuild when the [watcher]'s
  /// value changes. It provides the previous and current values of the [watcher], allowing for fine-grained
  /// control over the widget's rebuilding process.
  ///
  /// This function can be used to optimize performance by preventing unnecessary rebuilds. If it returns [true],
  /// the [builder] function is called to rebuild the widget. If [false], the widget is not rebuilt.
  /// If left null, the widget rebuilds on every value change of the [watcher].
  final bool Function(T previous, T current)? watchWhen;

  /// [threshold]
  ///
  /// An optional duration to delay the rebuild of the widget after state changes.
  /// If set, the widget will only consider rebuilding after this duration has elapsed since the last rebuild,
  /// providing a way to limit the frequency of rebuilds during rapid state changes.
  final Duration? threshold;

  @override
  State<WatchValue<T>> createState() => _WatchValueState<T>();
}

class _WatchValueState<T> extends State<WatchValue<T>> {
  T? _prevValue;
  DateTime? _lastBuildTime;

  void _listener() {
    final w = widget.watcher;
    final previousValue = _prevValue;

    // Check if the threshold has passed since the last rebuild
    if (widget.threshold != null) {
      final canRebuild = _lastBuildTime == null ||
          DateTime.now().difference(_lastBuildTime!) > widget.threshold!;
      if (canRebuild) _updateValue(previousValue, w.value);
    } else {
      _updateValue(previousValue, w.value);
    }
  }

  void _updateValue(T? previous, T current) {
    if (previous == null ||
        (widget.watchWhen?.call(previous, current) ?? true)) {
      // if (mounted) {
      setState(() {
        _prevValue = current;
        if (widget.threshold != null) _lastBuildTime = DateTime.now();
      });
      // }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.watcher.addListener(_listener);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('prevValue', _prevValue));
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, widget.watcher.value);

  @override
  void dispose() {
    widget.watcher.removeListener(_listener);
    super.dispose();
  }
}
