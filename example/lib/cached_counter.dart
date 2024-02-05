import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

main() async {
  runApp(CachedCounter());
}

class CachedCounter extends StatelessWidget {
  CachedCounter({super.key});

  final counter = 0.cachedWatcher('counter');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Counter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Watch Counter'),
          leading: IconButton(
            icon: counter.watchValue(
              (_) => Icon(
                counter.isCaching ? Icons.stop_circle : Icons.play_arrow,
              ),
            ),
            onPressed: () => counter.isCaching
                ? counter.stopCaching()
                : counter.startCaching(),
          ),
        ),
        body: Center(
          child: WatchValue(
            watchWhen: (prev, curr) => prev != curr,
            watcher: counter,
            builder: (context, value) {
              return Text('Counter: $value');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
