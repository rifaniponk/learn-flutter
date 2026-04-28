abstract class CounterRepository {
  int getCounter();
  int incrementCounter();
  int decrementCounter();
}

class InMemoryCounterRepository implements CounterRepository {
  int _counter = 0;

  @override
  int getCounter() => _counter;

  @override
  int incrementCounter() {
    _counter++;
    return _counter;
  }

  @override
  int decrementCounter() {
    _counter--;
    return _counter;
  }
}
