import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/reusable_container.dart';
import '../providers/push_counter_providers.dart';

class PushCounterPage extends ConsumerWidget {
  const PushCounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(pushCounterNotifierProvider);
    final notifier = ref.read(pushCounterNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ReusableContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Push Counter:'),
                    Text(
                      '$counter',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: 'decrementBtn',
                onPressed: notifier.decrementCounter,
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
              ),
              FloatingActionButton(
                heroTag: 'incrementBtn',
                onPressed: notifier.incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
