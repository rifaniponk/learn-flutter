import 'package:flutter/material.dart';

import '../../../shared/widgets/ui/ui.dart';
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

  static const _tabs = [
    AppBottomNavItem(
      icon: Icons.touch_app_outlined,
      activeIcon: Icons.touch_app,
      label: 'Counter',
    ),
    AppBottomNavItem(
      icon: Icons.checklist_outlined,
      activeIcon: Icons.checklist,
      label: 'To-do',
    ),
    AppBottomNavItem(
      icon: Icons.catching_pokemon_outlined,
      activeIcon: Icons.catching_pokemon,
      label: 'Pokémon',
    ),
    AppBottomNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  static const _titles = ['Counter', 'To-do list', 'Pokémon', 'Settings'];

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const PushCounterPage(),
      const TodoListPage(),
      const PokemonsPage(),
      const SettingPage(),
    ];

    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      // Custom app bar — no shadow, big personality title.
      appBar: AppBar(
        title: Text(_titles[_selectedTabIndex]),
      ),
      // Animated page swap so tab switches feel intentional.
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: KeyedSubtree(
          key: ValueKey(_selectedTabIndex),
          child: pages[_selectedTabIndex],
        ),
      ),
      // Custom floating bottom nav instead of Material's BottomNavigationBar.
      bottomNavigationBar: AppBottomNav(
        items: _tabs,
        currentIndex: _selectedTabIndex,
        onTap: _onTabChanged,
      ),
    );
  }
}
