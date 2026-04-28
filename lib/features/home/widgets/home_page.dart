import 'package:flutter/material.dart';

import 'push_counter_page.dart';
import 'setting_page.dart';
import 'todo_list_page.dart';
import '../view_models/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel, required this.title});

  final HomeViewModel viewModel;
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
      PushCounterPage(viewModel: widget.viewModel),
      const TodoListPage(),
      const SettingPage(),
    ];

    final titles = <String>[
      '${widget.title} - Push Counter',
      '${widget.title} - To Do List',
      '${widget.title} - Setting',
    ];

    final isCounterTab = _selectedTabIndex == 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(titles[_selectedTabIndex]),
      ),
      body: tabs[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _onTabChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Push Counter',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'To Do List'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isCounterTab
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: 'decrementBtn',
                    onPressed: widget.viewModel.decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: 'incrementBtn',
                    onPressed: widget.viewModel.incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
