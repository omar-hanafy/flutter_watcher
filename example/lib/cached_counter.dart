import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

main() async {
  runApp(CachedCounter());
}

class CachedCounter extends StatelessWidget {
  CachedCounter({super.key});

  // this can also be initialized in another class (e.g. singleton class)
  // and change its value any where for more scaled state management
  final counter = 0.cachedWatcher('counter');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cached Counter',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cached Counter'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.black,
              ),
              onPressed: () => counter.deleteCache(),
              tooltip: 'Clear Counter Cache',
            ),
          ],
          leading: IconButton(
            icon: counter.watch(
              () => Icon(
                counter.isCaching ? Icons.stop_circle : Icons.play_arrow,
              ),
            ),
            onPressed: () => counter.isCaching
                ? counter.stopCaching()
                : counter.startCaching(),
            tooltip: counter.isCaching ? 'Stop Caching' : 'Start Caching',
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
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
