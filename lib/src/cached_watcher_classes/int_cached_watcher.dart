import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// IntCachedWatcher
///
/// A [CachedWatcher] specialized for integer values. Ideal for caching counts, indexes, and other integer-based settings.
class IntCachedWatcher extends CachedWatcher<int> {
  IntCachedWatcher(super.initialValue, String key) : super(key: key);

  @override
  int? read(dynamic data) => tryToInt(data);

  @override
  dynamic write(int value) => value;
}
//
// /// [IntCachedWatcher] with Null Safety
// class IntNCachedWatcher extends CachedWatcher<int?> {
//   IntNCachedWatcher(String key, {int? initialValue})
//       : super(initialValue, key: key);
//
//   @override
//   int? read(dynamic data) => tryToInt(data);
//
//   @override
//   dynamic write(int? value) => value;
// }
