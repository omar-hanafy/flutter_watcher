import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

extension StreamToWatcher<T> on Stream<T> {
  ValueNotifier<T> toWatcher(
    T initialValue, {
    void Function(T)? onDone,
    void Function(Object, StackTrace)? onError,
  }) {
    final watcher = Watcher<T>(initialValue);
    listen(
      (value) => watcher.value = value,
      onError: onError ?? _defaultOnError,
      onDone: () => onDone?.call(watcher.value),
    );
    return watcher;
  }

  void _defaultOnError(Object error, StackTrace stackTrace) => log(
        'Error on stream $toString()',
        error: error,
        stackTrace: stackTrace,
      );
}
