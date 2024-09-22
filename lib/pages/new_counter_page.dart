import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/counter.dart';
import '../providers/main_provider.dart';

class NewCounterPage extends ConsumerStatefulWidget {
  const NewCounterPage({super.key});

  @override
  ConsumerState<NewCounterPage> createState() => _NewCounterPageState();
}

class _NewCounterPageState extends ConsumerState<NewCounterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final List<Counter> allCounters = ref.watch(countersNotifierProvider);

    int enteredId = 0;
    String enteredName = '';
    int enteredCountPoint = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add New Counter'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ID',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ID';
                    } else if (int.tryParse(value) == null) {
                      return 'Please enter a positive number as ID';
                    } else if (int.parse(value) <= 0) {
                      return 'Please enter a positive number as ID';
                    } else if (allCounters
                        .any((counter) => counter.id == int.parse(value))) {
                      return 'ID already exists';
                    }
                    return null;
                  },
                  onSaved: (newValue) => enteredId = int.parse(newValue!),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  onSaved: (newValue) => enteredName = newValue!,
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Count Point',
                  ),
                  initialValue: '0',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Count Point';
                    } else if (int.tryParse(value) == null) {
                      return 'Please enter a number as Count Point';
                    } else if (int.parse(value) < 0) {
                      return 'Please enter a non-negative number as Count Point';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) =>
                      enteredCountPoint = int.parse(newValue!),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final newCounter = Counter(
                        id: enteredId,
                        name: enteredName,
                        countPoint: enteredCountPoint,
                      );
                      ref
                          .read(countersNotifierProvider.notifier)
                          .addCounter(newCounter);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
