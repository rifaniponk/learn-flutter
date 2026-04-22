import 'package:flutter/material.dart';

import 'my_home_page.dart';
import 'widgets/reusable_container.dart';

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ReusableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Push Counter:'),
              Text('$_counter', style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
