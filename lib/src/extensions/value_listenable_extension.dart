import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ValueListenableBuilderExtension<T> on ValueListenable<T> {
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
  /// final myValueListenable = ValueNotifier<int>(0);
  /// final myValueStream = myValueListenable.stream;
  /// myValueStream.listen((value) {
  ///   // Handle the stream of changes here
  /// });
  /// ```
  Stream<T> get stream =>
      Stream.periodic(Duration.zero, (_) => value).distinct();

  /// [watch]
  ///
  /// A convenience method that wraps the current [ValueListenable] with a [ValueListenableBuilder],
  /// providing a straightforward way to build a widget in response to changes in the listenable's value.
  ///
  /// This method simplifies the creation of reactive UI components, where the UI needs to update whenever
  /// the underlying value changes. It takes a builder function that returns the widget to be displayed,
  /// ensuring that the UI stays in sync with the listenable's current value.
  ///
  /// Example:
  /// ```dart
  /// final myValueListenable = ValueNotifier<int>(0);
  /// final myWidget = myValueListenable.watch(
  ///   (value) => Text('Value is $value'),
  /// );
  /// // The Text widget will update whenever [myValueListenable] changes.
  /// ```
  Widget watch(Widget Function(T v) builder) {
    return ValueListenableBuilder<T>(
      valueListenable: this,
      builder: (_, v, __) => builder(v),
    );
  }
}
