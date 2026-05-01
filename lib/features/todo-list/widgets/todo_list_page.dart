import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/tokens.dart';
import '../../../shared/dialogs/show_confirm_dialog.dart';
import '../../../shared/widgets/ui/ui.dart';
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
          const SizedBox(height: AppTokens.space2),
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
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppTokens.space5,
            AppTokens.space4,
            AppTokens.space5,
            AppTokens.space2,
          ),
          child: Text(
            'Jot something down — keep it short and actionable.',
            style: textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.space5),
          child: AppCard(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppTokens.space4,
                      bottom: AppTokens.space2,
                    ),
                    child: Text(
                      'Task',
                      style: textTheme.labelMedium?.copyWith(
                        color: AppTokens.ink700,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          hint: 'What needs doing?',
                          prefixIcon: Icons.edit_note_rounded,
                          textInputAction: TextInputAction.done,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.transform<String>(
                            (value) => value?.trim() ?? '',
                            FormBuilderValidators.compose<String>([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(200),
                            ]),
                          ),
                          onSubmitted: (_) => _addTask(),
                        ),
                      ),
                      const SizedBox(width: AppTokens.space3),
                      AppButton(
                        label: 'Add',
                        icon: Icons.add_rounded,
                        onPressed: _addTask,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: todos.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTokens.space6),
                    child: AppCard(
                      variant: AppCardVariant.flat,
                      child: Text(
                        'Nothing here yet. Add your first task above.',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppTokens.ink500,
                        ),
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(AppTokens.space5),
                  itemCount: todos.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppTokens.space3),
                  itemBuilder: (context, index) {
                    final task = todos[index];
                    return AppCard(
                      variant: AppCardVariant.flat,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTokens.space3,
                        vertical: AppTokens.space1,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppTokens.space2,
                                horizontal: AppTokens.space2,
                              ),
                              child: Text(
                                task,
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _confirmDeleteTodo(task),
                            icon: const Icon(Icons.delete_outline_rounded),
                            style: IconButton.styleFrom(
                              foregroundColor: AppTokens.danger,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
