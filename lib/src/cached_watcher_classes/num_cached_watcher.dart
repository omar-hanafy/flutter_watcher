import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// NumCachedWatcher
///
/// A [CachedWatcher] specialized for numeric values. It is capable of handling both integers and floating-point numbers.
/// Useful for caching numerical configurations, scores, etc.
class NumCachedWatcher extends CachedWatcher<num> {
  NumCachedWatcher(super.initialValue, String key) : super(key: key);

  @override
  num? read(dynamic data) => tryToNum(data);

  @override
  dynamic write(num value) => value;
}

// /// [NumCachedWatcher] with Null Safety
// class NumNCachedWatcher extends CachedWatcher<num?> {
//   NumNCachedWatcher(String key, {num? initialValue})
//       : super(initialValue, key: key);
//
//   @override
//   num? read(dynamic data) => tryToNum(data);
//
//   @override
//   dynamic write(num? value) => value;
// }
