import 'package:flutter/material.dart';

import '../../push-counter/widgets/push_counter_page.dart';
import '../../setting/widgets/setting_page.dart';
import '../../todo-list/widgets/todo_list_page.dart';
import '../../pokemons/widgets/pokemons_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      const PushCounterPage(),
      const TodoListPage(),
      const SettingPage(),
      const PokemonsPage(),
    ];

    final titles = <String>[
      '${widget.title} - Push Counter',
      '${widget.title} - To Do List',
      '${widget.title} - Setting',
      '${widget.title} - Pokemons',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(titles[_selectedTabIndex]),
      ),
      body: tabs[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabChanged,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onSurface.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Push Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'To Do List',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokemons',
          ),
        ],
      ),
    );
  }
}
