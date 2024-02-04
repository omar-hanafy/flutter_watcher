import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// [Watch]
///
/// A flexible widget that rebuilds itself in response to changes in any [Listenable] object,
/// including [Watcher] instances. It monitors a specified `watcher` and triggers a rebuild
/// whenever the `watcher` notifies its listeners of updates.
///
/// The `Watch` widget is compatible with both custom and Flutter's native [Listenable] objects.
/// This includes, but is not limited to, [ValueNotifier], [AnimationController], [ScrollController] and [TextEditingController].
/// Its adaptability makes it ideal for various state management approaches,
/// integrating seamlessly with both custom [Listenable] implementations and Flutter’s own state management systems.
class Watch extends StatefulWidget {
  const Watch({
    required this.watcher,
    required this.builder,
    this.watchWhen,
    this.threshold,
    super.key,
  });

  /// A [Listenable] object that this widget is listening to.
  /// A [Listenable]
  ///
  /// The widget will rebuild whenever this `watcher` notifies its listeners.
  ///
  /// The `watcher` could be a [Watcher] instance or any any object that implements the [Listenable] interface,
  /// e.g. the Flutter's native objects, such as [ValueNotifier], [Animation], [TextEditingController], etc.
  final Listenable watcher;

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

  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  DateTime? _lastBuildTime;

  void _listener() {
    if ((widget.watchWhen?.call() ?? true) && _shouldRebuild()) {
      setState(() => _lastBuildTime = DateTime.now());
    }
  }

  bool _shouldRebuild() {
    if (widget.threshold == null || _lastBuildTime == null) return true;
    return DateTime.now().difference(_lastBuildTime!) > widget.threshold!;
  }

  @override
  void initState() {
    super.initState();
    widget.watcher.addListener(_listener);
  }

  @override
  void didUpdateWidget(Watch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.watcher != widget.watcher) {
      oldWidget.watcher.removeListener(_listener);
      widget.watcher.addListener(_listener);
    }
  }

  @override
  void dispose() {
    widget.watcher.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
