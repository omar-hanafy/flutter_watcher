import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MultiValueWatcher Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final counterWatcher = Watcher<int>(0);
  final stringWatcher = Watcher<String>('Hello World');

  final scrollController = ScrollController();

  final textCtrl = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Watch(
          watcher: scrollController,
          builder: (context) {
            return const Text('MultiValueWatcher Example');
          },
        ),
      ),
      body: WatchAll(
        watchers: [
          counterWatcher,
          stringWatcher,
        ],
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Counter value is $counterWatcher'),
                Text('String message is $stringWatcher'),
              ],
            ),
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
