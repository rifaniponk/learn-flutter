import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../shared/dialogs/show_confirm_dialog.dart';
import '../providers/todo_provider.dart';

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addTask() {
    if (_formKey.currentState?.validate() != true) return;

    final notifier = ref.read(todoListNotifierProvider.notifier);
    final text = _controller.text.trim();
    notifier.addTodo(text);
    _controller.clear();
    _focusNode.requestFocus();
  }

  Future<void> _confirmDeleteTodo(String todo) async {
    final theme = Theme.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete task?',
      cancelLabel: 'Cancel',
      confirmLabel: 'Delete',
      confirmIsDestructive: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you want to delete:',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(todo, style: theme.textTheme.titleSmall),
        ],
      ),
    );

    if (!context.mounted || confirmed != true) return;
    ref.read(todoListNotifierProvider.notifier).removeTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListNotifierProvider);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Enter a task',
                      labelText: 'Task',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.transform<String>(
                      (value) => value?.trim() ?? '',
                      FormBuilderValidators.compose<String>([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(200),
                      ]),
                    ),
                    onFieldSubmitted: (_) => _addTask(),
                  ),
                ),
                ElevatedButton(onPressed: _addTask, child: const Text('Add')),
              ],
            ),
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
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        todos[index],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _confirmDeleteTodo(todos[index]);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
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
