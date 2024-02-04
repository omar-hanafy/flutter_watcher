import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

main() async {
  runApp(const CachedCounter());
}

class CachedCounter extends StatefulWidget {
  const CachedCounter({super.key});

  @override
  State<CachedCounter> createState() => _CachedCounterState();
}

class _CachedCounterState extends State<CachedCounter> {
  // this can also be initialized in another class (e.g. singleton class)
  final counter = 0.cachedWatcher('counter');

  Future<void> _listen() async {
    print('CHECK IF PREMETIVE');
    final map = <String, dynamic>{
      'token': 'token',
      'userId': 12,
      'finishedOnboarding': true,
      'isFirstLogin': true,
    };
    print(isPrimitiveType(map));
    await 10.secDelay;
    counter.addListener(() {
      print('Started Listenening for counter .. now is $counter');
    });
  }

  @override
  void initState() {
    super.initState();
    _listen();
  }

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
