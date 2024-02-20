import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// create a [CachedWatcher] of type [Duration], which reacts just like normal [Duration],
/// but with watcher capabilities.
class DurationCachedWatcher extends CachedWatcher<Duration>
    implements Duration {
  DurationCachedWatcher(super.initialValue, String key) : super(key: key);

  /// documentation available in the original overridden method.
  @override
  Duration? read(dynamic data) =>
      data == null ? null : Duration(milliseconds: toInt(data));

  /// documentation available in the original overridden method.
  @override
  dynamic write(Duration value) => value.inMilliseconds;

  /// documentation available in the original overridden method.
  @override
  Duration operator *(num factor) => v * factor;

  /// documentation available in the original overridden method.
  @override
  Duration operator +(Duration other) => v + other;

  /// documentation available in the original overridden method.
  @override
  Duration operator -() => -v;

  /// documentation available in the original overridden method.
  @override
  Duration operator -(Duration other) => v - other;

  /// documentation available in the original overridden method.
  @override
  bool operator <(Duration other) => v < other;

  /// documentation available in the original overridden method.
  @override
  bool operator <=(Duration other) => v <= other;

  /// documentation available in the original overridden method.
  @override
  bool operator >(Duration other) => v > other;

  /// documentation available in the original overridden method.
  @override
  bool operator >=(Duration other) => v >= other;

  /// documentation available in the original overridden method.
  @override
  Duration operator ~/(int quotient) => v ~/ quotient;

  /// documentation available in the original overridden method.
  @override
  Duration abs() => v.abs();

  /// documentation available in the original overridden method.
  @override
  int compareTo(Duration other) => v.compareTo(other);

  /// documentation available in the original overridden method.
  @override
  int get inDays => v.inDays;

  /// documentation available in the original overridden method.
  @override
  int get inHours => v.inHours;

  /// documentation available in the original overridden method.
  @override
  int get inMicroseconds => v.inMicroseconds;

  /// documentation available in the original overridden method.
  @override
  int get inMilliseconds => v.inMilliseconds;

  /// documentation available in the original overridden method.
  @override
  int get inMinutes => v.inMinutes;

  /// documentation available in the original overridden method.
  @override
  int get inSeconds => v.inSeconds;

  /// documentation available in the original overridden method.
  @override
  bool get isNegative => v.isNegative;
}
