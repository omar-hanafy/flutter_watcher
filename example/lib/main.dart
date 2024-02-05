import 'package:flutter/material.dart';
import 'package:flutter_watcher/flutter_watcher.dart';

main() => runApp(MyCounter());

class MyCounter extends StatelessWidget {
  MyCounter({super.key});

  final counter = 0.watcher;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Counter',
      home: Scaffold(
        appBar: AppBar(title: const Text('Watch Counter')),
        body: Center(
          child: counter.watchValue(
            (value) {
              return Text('Counter: $value');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.increment(1),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
