import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

extension WatcherListenableExtension on Listenable {
  Widget watch(
    Widget Function() builder, {
    bool Function()? watchWhen,
    Duration? threshold,
  }) {
    return Watch(
      watcher: this,
      watchWhen: watchWhen,
      threshold: threshold,
      builder: (_) => builder(),
    );
  }
}

extension WatcherListenablesExtension on List<Listenable?> {
  Widget watchAll(
    Widget Function() builder, {
    bool Function()? watchWhen,
    Duration? threshold,
  }) {
    return WatchAll(
      watchers: this,
      watchWhen: watchWhen,
      threshold: threshold,
      builder: (_) => builder(),
    );
  }
}

extension ValueListenableBuilderExtension<T> on Watcher<T> {
  /// [stream]
  ///
  /// Converts the [ValueListenable] into a [Stream]. This stream emits values whenever the
  /// listenable's value changes. The use of [distinct] ensures that consecutive duplicate values are
  /// filtered out, thus the stream only emits when the value actually changes.
  ///
  /// This conversion enables the integration of [ValueListenable] with reactive programming patterns,
  /// allowing for more complex and dynamic handling of the listenable's value changes in scenarios where
  /// streams are preferred or more efficient.
  ///
  /// Example:
  /// ```dart
  /// final myWatcher = 0.watcher;
  /// final myWatcherStream = myWatcher.stream;
  /// myValueStream.listen((value) {
  ///   // Handle the stream of changes here
  /// });
  /// ```
  Stream<T> get stream =>
      Stream.periodic(Duration.zero, (_) => value).distinct();

  /// [watchValue]
  ///
  /// A convenience method that wraps the current [Watcher] or any [ValueListenable] type with a [WatchValue],
  /// providing a straightforward way to build a widget in response to changes in the listenable's value.
  ///
  /// This method simplifies the creation of reactive UI components, where the UI needs to update whenever
  /// the underlying value changes. It takes a builder function that returns the widget to be displayed,
  /// ensuring that the UI stays in sync with the listenable's current value.
  ///
  /// Example:
  /// ```dart
  /// final myWatcher = 0.watcher;
  /// final myWidget = myWatcher.watchValue(
  ///   (value) => Text('Value is $value'),
  /// );
  /// // The Text widget will update whenever [myWatcher] changes.
  /// ```
  Widget watchValue(
    Widget Function(T v) builder, {
    bool Function(T previous, T current)? watchWhen,
    Duration? threshold,
  }) {
    return WatchValue(
      watcher: this,
      watchWhen: watchWhen,
      threshold: threshold,
      builder: (_, v) => builder(v),
    );
  }
}
