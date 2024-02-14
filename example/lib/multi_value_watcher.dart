import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MultiWatchValueer Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final counter = Watcher<int>(0);
  final lastUpdated = Watcher<String>('Hello World');

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Watch(
          watcher: scrollController,
          builder: (context) {
            return const Text('MultiWatchValueer Example');
          },
        ),
      ),
      body: WatchAll(
        watchers: [
          counter,
          lastUpdated,
        ],
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Counter value is $counter'),
              Text('String message is $lastUpdated'),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterWatcher.value++;
          stringWatcher.value = 'Updated at ${DateTime.now()}';
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
