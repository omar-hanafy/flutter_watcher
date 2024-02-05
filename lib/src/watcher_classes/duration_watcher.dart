import 'package:flutter_watcher/flutter_watcher.dart';

/// allows to quickly create a Watcher of type Duration.
class DurationWatcher extends Watcher<Duration> implements Duration {
  DurationWatcher(super.initial);

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
