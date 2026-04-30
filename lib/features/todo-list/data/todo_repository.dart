abstract class TodoRepository {
  List<String> getTodos();
  void addTodo(String todo);
  void removeTodo(String todo);
  void clearTodos();
}

class InMemoryTodoRepository implements TodoRepository {
  final List<String> _todos = [];

  @override
  List<String> getTodos() => List.unmodifiable(_todos);

  @override
  void addTodo(String todo) {
    _todos.add(todo);
  }

  @override
  void removeTodo(String todo) {
    _todos.remove(todo);
  }

  @override
  void clearTodos() {
    _todos.clear();
  }
}
