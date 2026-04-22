import 'package:flutter/material.dart';

import '../features/home/data/counter_repository.dart';
import '../features/home/view_models/home_view_model.dart';
import '../features/home/widgets/home_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final CounterRepository _counterRepository;
  late final HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _counterRepository = InMemoryCounterRepository();
    _homeViewModel = HomeViewModel(counterRepository: _counterRepository);
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
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
      home: HomePage(viewModel: _homeViewModel, title: 'Flutter Demo'),
    );
  }
}
