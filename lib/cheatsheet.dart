//! ** Riverpod set up **
// Install these:
// flutter pub add flutter_riverpod
// flutter pub add riverpod_annotation
// flutter pub add dev:riverpod_generator
// flutter pub add dev:build_runner

// ProviderScope in main.dart


//! ** Easy level **
// StateProvider

// ConsumerWidget
// ref.watch(riverpod)
// ref.read(riverpod.notifier).state


//! ** Hard level (With a model) **
// ChangeNotifierProvider
// ChangeNotifier
// notifyListeners

// ConsumerWidget
// ref.watch(riverpod).name
// ref.read(riverpod).changeName(newName: newValue)


//! ** PS **
// Watch = Listen to changes
// Read = Don't listen to changes (Edit the value)