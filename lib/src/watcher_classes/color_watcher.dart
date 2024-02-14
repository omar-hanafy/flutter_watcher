import 'package:flutter/cupertino.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// allows to quickly create a Watcher of type Color.
class ColorWatcher extends Watcher<Color> {
  ColorWatcher(super.initial);
}

/// Extension: ColorWatcherExtension
///
/// Description:
/// Adds convenience methods to `Watcher<Color>` for managing color state changes
/// in a more intuitive and expressive manner.
/// This extension leverages the `Watcher` functionality to make it easier to
/// work with color animations, themes,
/// and dynamic UI elements that depend on color changes.
///
/// Usage:
/// This extension can be directly used on any `ValueNotifier<Color>` instance,
/// providing additional methods specific to color manipulation and state management.
/// It simplifies the process of updating and responding to color changes within the Flutter UI.
///
/// Example:
/// ```dart
/// final colorWatcher = Colors.blue.watcher;
/// colorWatcher.withOpacity(0.5);
///

extension ColorWatcherExtension on Watcher<Color> {
  int get alpha => value.alpha;

  int get blue => value.blue;

  int get green => value.green;

  double get opacity => value.opacity;

  int get red => value.red;

  double computeLuminance() => value.computeLuminance();

  Color withAlpha(int a) => value.withAlpha(a);

  Color withBlue(int b) => value.withBlue(b);

  Color withGreen(int g) => value.withGreen(g);

  Color withOpacity(double opacity) => value.withOpacity(opacity);

  Color withRed(int r) => value.withRed(r);
}
