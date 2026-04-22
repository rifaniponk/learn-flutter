import 'package:flutter/foundation.dart';

import '../data/counter_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required CounterRepository counterRepository})
    : _counterRepository = counterRepository,
      _counter = counterRepository.getCounter();

  final CounterRepository _counterRepository;
  int _counter;

  int get counter => _counter;

  void incrementCounter() {
    _counter = _counterRepository.incrementCounter();
    notifyListeners();
  }
}
