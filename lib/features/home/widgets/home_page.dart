import 'package:flutter/material.dart';

import '../../../shared/widgets/reusable_container.dart';
import '../view_models/home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.viewModel, required this.title});

  final HomeViewModel viewModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: ReusableContainer(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (_, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Push Counter:'),
                  Text(
                    '${viewModel.counter}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
