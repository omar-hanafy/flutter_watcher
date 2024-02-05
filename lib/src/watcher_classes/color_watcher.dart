import 'dart:ui';

import 'package:flutter_watcher/flutter_watcher.dart';

/// allows to quickly create a Watcher of type Color.
class ColorWatcher extends Watcher<Color> {
  ColorWatcher(super.initial);
}

extension ColorWatcherExtension on Watcher<Color> {
  int get alpha => v.alpha;

  int get blue => v.blue;

  int get green => v.green;

  double get opacity => v.opacity;

  int get red => v.red;

  double computeLuminance() => v.computeLuminance();

  Color withAlpha(int a) => v.withAlpha(a);

  Color withBlue(int b) => v.withBlue(b);

  Color withGreen(int g) => v.withGreen(g);

  Color withOpacity(double opacity) => v.withOpacity(opacity);

  Color withRed(int r) => v.withRed(r);
}
