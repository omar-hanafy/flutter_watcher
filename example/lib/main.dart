import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_watcher/flutter_watcher.dart';
import 'package:get/state_manager.dart';

main() => runApp(MyCounter());

class MyCounter extends StatelessWidget {
  MyCounter({super.key});

  // this can also be initialized in another class (e.g. singleton class)
  // and change its value any where for more scaled state management
  final Rx<int?> rxCounter = null.obs;
  final Watcher<int?> counter = Watcher(null);
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Counter',
      home: Scaffold(
        appBar: AppBar(
          title: controller.watch(
            threshold: 500.asMilliseconds,
            () => Text('Watch Counter ${controller.offset.asGreeks}'),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: counter.watchValue(
                threshold: 20.asSeconds,
                (value) {
                  return Text('Counter: $value');
                },
              ),
            ),
            Center(
              child: Obx(
                () {
                  return Text('Counter: ${rxCounter.value}');
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: 200,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(height: 50, child: Card(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            counter.v = (counter.v ?? 0) + 1;
            rxCounter.value = (rxCounter.value ?? 0) + 1;
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
