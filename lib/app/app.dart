import 'package:flutter/material.dart';

import '../features/home/widgets/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 201, 102, 22),
        ),
      ),
      home: const HomePage(title: 'Flutter Demo'),
    );
  }
}
