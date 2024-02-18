import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// DoubleCachedWatcher
///
/// A [CachedWatcher] specialized for double values. Best suited for caching floating-point numbers like percentages, dimensions, etc.
class DoubleCachedWatcher extends CachedWatcher<double> {
  DoubleCachedWatcher(super.initialValue, String key) : super(key: key);

  @override
  double? read(dynamic data) => tryToDouble(data);

  @override
  dynamic write(double value) => value;
}
//
// /// [DoubleCachedWatcher] with Null Safety
// class DoubleNCachedWatcher extends CachedWatcher<double?> {
//   DoubleNCachedWatcher(String key, {double? initialValue})
//       : super(initialValue, key: key);
//
//   @override
//   double? read(dynamic data) => tryToDouble(data);
//
//   @override
//   dynamic write(double? value) => value;
// }
