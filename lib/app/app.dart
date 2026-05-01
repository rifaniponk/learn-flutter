import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../features/home/widgets/home_page.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: FormBuilderLocalizations.localizationsDelegates,
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      // Identical scrollbars / overscroll on every platform.
      scrollBehavior: const AppScrollBehavior(),
      theme: AppTheme.light,
      home: const HomePage(title: 'Flutter Demo'),
    );
  }
}
