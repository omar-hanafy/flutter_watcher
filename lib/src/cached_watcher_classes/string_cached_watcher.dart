import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// StringCachedWatcher
///
/// A [CachedWatcher] specialized for String values. Useful for caching textual data like user inputs, configuration strings, etc.
class StringCachedWatcher extends CachedWatcher<String> {
  StringCachedWatcher(super.initialValue, String key) : super(key: key);

  @override
  String? read(dynamic data) => tryToString(data);

  @override
  dynamic write(String value) => value;
}

/// [StringCachedWatcher] with Null Safety
class StringCachedWatcherN extends CachedWatcher<String?> {
  StringCachedWatcherN(String key, {String? initialValue})
      : super(initialValue, key: key);

  @override
  String? read(dynamic data) => tryToString(data);

  @override
  dynamic write(String? value) => value;
}
