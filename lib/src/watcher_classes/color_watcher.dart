import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// allows to quickly create a Watcher of type Color.
class ColorWatcher extends Watcher<Color> {
  ColorWatcher(super.initial);
}

extension ColorWatcherExtension on ValueNotifier<Color> {
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
