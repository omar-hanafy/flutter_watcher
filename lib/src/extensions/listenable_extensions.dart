import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

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
