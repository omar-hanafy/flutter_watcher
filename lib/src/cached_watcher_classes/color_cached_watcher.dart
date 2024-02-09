
import 'dart:ui';

import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// ColorCachedWatcher
///
/// A [CachedWatcher] for Color objects. Ideal for persisting theme colors, user-selected colors, and other UI-related color data.
class ColorCachedWatcher extends CachedWatcher<Color> {
  ColorCachedWatcher(super.initialValue, String key) : super(key: key);

  @override
  Color? read(dynamic data) => data?.toString().toColor;

  @override
  dynamic write(Color value) => v.toHex();
}

/// [ColorCachedWatcher] with Null Safety
class ColorCachedWatcherN extends CachedWatcher<Color?> {
  ColorCachedWatcherN(String key, {Color? initialValue})
      : super(initialValue, key: key);

  @override
  Color? read(dynamic data) => data?.toString().toColor;

  @override
  dynamic write(Color? value) => value?.toHex();
}
