import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

/// BoolCachedWatcher
///
/// A [CachedWatcher] specialized for boolean values. It handles the caching of boolean state.
/// Ideal for persisting feature toggles, user preferences, etc.
class BoolCachedWatcher extends CachedWatcher<bool> {
  BoolCachedWatcher(super.initialValue, String key) : super(key: key);

  @override
  bool? read(dynamic data) => tryToBool(data);

  @override
  dynamic write(bool value) => value;
}

/// [BoolCachedWatcher] with Null Safety
class BoolCachedWatcherN extends CachedWatcher<bool?> {
  BoolCachedWatcherN(String key, {bool? initialValue})
      : super(initialValue, key: key);

  @override
  bool? read(dynamic data) => tryToBool(data);

  @override
  dynamic write(bool? value) => value;
}

