import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// Extension on [Listenable] to integrate with the [Watch] widget.
///
/// Provides a convenient method to create a [Watch] widget that listens to the [Listenable].
/// This extension simplifies reacting to changes in the [Listenable] within the UI.
extension WatcherListenableExtension on Listenable {
  /// [watch]
  /// This method simplifies the creation of [Watch]
  ///
  /// Example:
  /// ```dart
  /// final myWatcher = 0.watcher;
  /// controller.watch(
  ///   (context) => Text('Value is ${myWatcher.value}'),
  /// );
  /// // The Text widget will update whenever [myWatcher] changes.
  /// ```
  Widget watch(
    Widget Function(BuildContext context) builder, {
    bool Function()? watchWhen,
    Duration? threshold,
  }) {
    return Watch(
      watcher: this,
      watchWhen: watchWhen,
      threshold: threshold,
      builder: builder,
    );
  }
}

/// Extension on a list of [Listenable] objects to integrate with the [WatchAll] widget.
///
/// Facilitates the creation of a [WatchAll] widget that listens to multiple [Listenable] instances.
/// Ideal for scenarios where UI needs to respond to changes in multiple listenable sources.
extension WatcherListenablesExtension on List<Listenable?> {
  /// [watchAll]
  /// This method simplifies the creation of [WatchAll]
  ///
  /// Example:
  /// ```dart
  /// final textController = TextEditingController();
  /// final scrollController = ScrollController();
  /// final myWatcher = 0.watcher;
  /// final myListeners = <Listenable>[textController, scrollController, myWatcher];
  /// myListeners.watchAll(
  ///   (context) => Text('Value is $value'),
  /// );
  /// // The Text widget will update whenever any of myListeners changes.
  /// ```
  Widget watchAll(
    Widget Function(BuildContext context) builder, {
    bool Function()? watchWhen,
    Duration? threshold,
  }) {
    return WatchAll(
      watchers: this,
      watchWhen: watchWhen,
      threshold: threshold,
      builder: builder,
    );
  }
}

/// Extension on [ValueListenable] to seamlessly create a [WatchValue] widget.
///
/// Simplifies the instantiation of [WatchValue], allowing for direct UI updates in response to [ValueListenable] changes.
/// Enhances code readability and efficiency by reducing boilerplate.
extension WatcherValueListenableExtension<T> on ValueListenable<T> {
  /// [watchValue]
  /// This method simplifies the creation of [WatchValue]
  ///
  /// Example:
  /// ```dart
  /// final myWatcher = 0.watcher;
  /// myWatcher.watchValue(
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
