import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/counter.dart';
import 'package:riverpod_app/pages/counter_page.dart';
import 'package:riverpod_app/pages/new_counter_page.dart';
import 'package:riverpod_app/providers/main_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Counter> allCounters = ref.watch(countersNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Column(
          children: [
            Text('Multi Counter'),
            Text(
              'Riverpod App',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...allCounters.map((counter) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                right: 10.0,
                left: 10.0,
              ),
              child: Dismissible(
                onDismissed: (direction) {
                  ref
                      .read(countersNotifierProvider.notifier)
                      .deleteCounter(counter.id);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                key: ValueKey(counter.id),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CounterPage(id: counter.id),
                        ));
                  },
                  tileColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Row(
                    children: [
                      Text(counter.name),
                      const Expanded(child: SizedBox()),
                      Text(counter.countPoint.toString()),
                    ],
                  ),
                ),
              ),
            );
          }),
          if (allCounters.isEmpty)
            const Center(
              heightFactor: 2.0,
              child: Text('No Counters Yet'),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewCounterPage()),
        ),
        tooltip: 'Add new Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
