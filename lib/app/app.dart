import 'package:flutter/material.dart';

import '../features/home/widgets/home_page.dart';
import '../features/push-counter/data/counter_repository.dart';
import '../features/push-counter/view_models/push_counter_view_model.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final CounterRepository _counterRepository;
  late final PushCounterViewModel _pushCounterViewModel;

  @override
  void initState() {
    super.initState();
    _counterRepository = InMemoryCounterRepository();
    _pushCounterViewModel = PushCounterViewModel(
      counterRepository: _counterRepository,
    );
  }

  @override
  void dispose() {
    _pushCounterViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 201, 102, 22),
        ),
      ),
      home: HomePage(viewModel: _pushCounterViewModel, title: 'Flutter Demo'),
    );
  }
}
