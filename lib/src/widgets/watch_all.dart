import 'package:flutter/material.dart';

/// [WatchAll]
///
/// A dynamic widget designed to rebuild itself in response to changes in multiple [Listenable] objects.
/// It listens to a collection of `watchers`, each being a [Listenable] object. This includes custom [Watcher]
/// instances as well as other [Listenable] types available in Flutter.
///
/// `WatchAll` offers a practical approach for reactive UI updates. It triggers a rebuild whenever any
/// of the specified watchers notify their listeners of changes, ensuring an up-to-date UI.
class WatchAll extends StatefulWidget {
  const WatchAll({
    required this.watchers,
    required this.builder,
    this.watchWhen,
    this.threshold,
    super.key,
  });

  /// A list of [Listenable] objects that this widget is listening to.
  /// The widget will be rebuilt when any of the `watchers` notify their listeners. This list
  /// can include any mix of [Watcher] instances or other [Listenable] types, making it
  /// flexible for different use cases.
  final List<Listenable?> watchers;

  /// A function that defines the widget to be built based on the current context.
  /// This function is called whenever the widget needs to rebuild, providing the flexibility
  /// to design responsive and dynamic UI components that react to state changes.
  final Widget Function(BuildContext context) builder;

  /// An optional callback that determines whether the widget should rebuild when
  /// any of the `watchers` notify their listeners. It can be used to optimize performance by
  /// preventing unnecessary rebuilds. If it returns `true`, the [builder] function is called
  /// to rebuild the widget. If `false`, the widget is not rebuilt. If left `null`, the widget
  /// rebuilds on every notification from the `watchers`.
  final bool Function()? watchWhen;

  /// An optional [Duration] that sets a time limit for how frequently the widget can
  /// rebuild in response to `watchers` notifications. If set, the widget will only consider
  /// rebuilding after this duration has elapsed since the last rebuild, providing a way to limit
  /// the frequency of rebuilds during rapid state changes. This feature is particularly useful
  /// for optimizing performance and avoiding flickering in the UI.
  final Duration? threshold;

  void _addListeners(VoidCallback listener) {
    for (final watcher in watchers) {
      if (watcher != null) watcher.addListener(listener);
    }
  }

  void _removeListeners(VoidCallback listener) {
    for (final watcher in watchers) {
      if (watcher != null) watcher.removeListener(listener);
    }
  }

  @override
  State<WatchAll> createState() => _WatchAllState();
}

class _WatchAllState extends State<WatchAll> {
  DateTime? _lastBuildTime;

  @override
  void initState() {
    super.initState();
    widget._addListeners(_listener);
  }

  void _listener() {
    if ((widget.watchWhen?.call() ?? true) && _shouldRebuild()) {
      setState(() {
        _lastBuildTime = DateTime.now();
      });
    }
  }

  bool _shouldRebuild() {
    if (widget.threshold == null || _lastBuildTime == null) return true;
    return DateTime.now().difference(_lastBuildTime!) > widget.threshold!;
  }

  @override
  void didUpdateWidget(WatchAll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.watchers != widget.watchers) {
      oldWidget._removeListeners(_listener);
      widget._addListeners(_listener);
    }
  }

  @override
  void dispose() {
    widget._removeListeners(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
