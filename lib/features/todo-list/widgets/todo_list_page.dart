import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'To Do List coming soon',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
