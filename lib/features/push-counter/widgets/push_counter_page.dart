import 'package:flutter/material.dart';

import '../../../shared/widgets/reusable_container.dart';
import '../view_models/push_counter_view_model.dart';

class PushCounterPage extends StatelessWidget {
  const PushCounterPage({super.key, required this.viewModel});

  final PushCounterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ReusableContainer(
        color: const Color.fromARGB(255, 204, 248, 255),
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
    );
  }
}
