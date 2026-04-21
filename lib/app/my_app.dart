import 'package:flutter/material.dart';

import '../features/home/my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 201, 102, 22),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}
