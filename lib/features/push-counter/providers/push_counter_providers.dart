import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/counter_repository.dart';

final counterRepositoryProvider = Provider<CounterRepository>(
  (_) => InMemoryCounterRepository(),
);

final pushCounterNotifierProvider = NotifierProvider<PushCounterNotifier, int>(
  PushCounterNotifier.new,
);

class PushCounterNotifier extends Notifier<int> {
  late final CounterRepository _counterRepository;

  @override
  int build() {
    _counterRepository = ref.read(counterRepositoryProvider);
    return _counterRepository.getCounter();
  }

  void incrementCounter() {
    state = _counterRepository.incrementCounter();
  }

  void decrementCounter() {
    state = _counterRepository.decrementCounter();
  }
}
