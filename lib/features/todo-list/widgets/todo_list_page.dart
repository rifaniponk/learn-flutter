import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/todo_provider.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListNotifierProvider);
    final notifier = ref.read(todoListNotifierProvider.notifier);

    TextEditingController controller = TextEditingController();

    void addTask() {
      if (controller.text.isEmpty) return;
      notifier.addTodo(controller.text);
      controller.clear();
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Enter a task'),
                  onSubmitted: (value) {
                    addTask();
                  },
                ),
              ),
              ElevatedButton(onPressed: addTask, child: Text('Add')),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    todos[index],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
