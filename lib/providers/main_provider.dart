import 'package:riverpod_app/models/counter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_provider.g.dart';

//! Terminal command to build
// dart run build_runner watch

@riverpod
class CountersNotifier extends _$CountersNotifier {
  @override
  List<Counter> build() {
    return [];
  }

  void addCounter(Counter counter) {
    state = [...state, counter];
  }

  void updateCounter(int id, Counter counter) {
    state = state.map((c) {
      if (c.id == id) {
        return counter;
      }
      return c;
    }).toList();
  }

  void deleteCounter(int id) {
    state = state.where((c) => c.id != id).toList();
  }
}
