import 'dart:async';

import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// allows to quickly create a Watcher of type Duration.
class DurationCachedWatcher extends CachedWatcher<Duration>
    implements Duration {
  DurationCachedWatcher(super.initialValue, String key) : super(key: key);

  @override
  Duration? read(dynamic data) =>
      data == null ? null : Duration(milliseconds: toInt(data));

  @override
  dynamic write(Duration value) => value.inMilliseconds;

  @override
  Duration operator *(num factor) => v * factor;

  @override
  Duration operator +(Duration other) => v + other;

  @override
  Duration operator -() => -v;

  @override
  Duration operator -(Duration other) => v - other;

  @override
  bool operator <(Duration other) => v < other;

  @override
  bool operator <=(Duration other) => v <= other;

  @override
  bool operator >(Duration other) => v > other;

  @override
  bool operator >=(Duration other) => v >= other;

  @override
  Duration operator ~/(int quotient) => v ~/ quotient;

  @override
  Duration abs() => v.abs();

  @override
  int compareTo(Duration other) => v.compareTo(other);

  @override
  int get inDays => v.inDays;

  @override
  int get inHours => v.inHours;

  @override
  int get inMicroseconds => v.inMicroseconds;

  @override
  int get inMilliseconds => v.inMilliseconds;

  @override
  int get inMinutes => v.inMinutes;

  @override
  int get inSeconds => v.inSeconds;

  @override
  bool get isNegative => v.isNegative;
}
