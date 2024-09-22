import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/providers/main_provider.dart';
import '../models/counter.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Counter> allCounters = ref.watch(countersNotifierProvider);
    final Counter selectedCounter =
        allCounters.firstWhere((counter) => counter.id == id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(selectedCounter.name),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${selectedCounter.countPoint}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton.large(
              onPressed: () => ref
                  .read(countersNotifierProvider.notifier)
                  .updateCounter(
                      id,
                      Counter(
                          id: selectedCounter.id,
                          name: selectedCounter.name,
                          countPoint: selectedCounter.countPoint - 1)),
              tooltip: 'Minus',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton.large(
              onPressed: () => ref
                  .read(countersNotifierProvider.notifier)
                  .updateCounter(
                      id,
                      Counter(
                          id: selectedCounter.id,
                          name: selectedCounter.name,
                          countPoint: selectedCounter.countPoint + 1)),
              tooltip: 'Plus',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
