import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/todo_repository.dart';

final todoRepositoryProvider = Provider<TodoRepository>(
  (_) => InMemoryTodoRepository(),
);

final todoListNotifierProvider =
    NotifierProvider<TodoListNotifier, List<String>>(TodoListNotifier.new);

class TodoListNotifier extends Notifier<List<String>> {
  late final TodoRepository _todoRepository;

  @override
  List<String> build() {
    _todoRepository = ref.read(todoRepositoryProvider);
    return _todoRepository.getTodos();
  }

  void addTodo(String todo) {
    _todoRepository.addTodo(todo);
    state = _todoRepository.getTodos();
  }

  void removeTodo(String todo) {
    _todoRepository.removeTodo(todo);
    state = _todoRepository.getTodos();
  }

  void clearTodos() {
    _todoRepository.clearTodos();
    state = _todoRepository.getTodos();
  }
}
