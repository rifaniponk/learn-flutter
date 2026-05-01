import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../features/home/widgets/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // A complete orange palette (Material 3 friendly).
    // Keep `inversePrimary == primary` so AppBar's `backgroundColor: inversePrimary`
    // still contrasts nicely with `onPrimary`.
    const primary = Color(0xFFF26A1B);
    const onPrimary = Color(0xFFFFFFFF);
    const primaryContainer = Color(0xFFFFD8C2);
    const onPrimaryContainer = Color(0xFF4A1E00);

    const secondary = Color(0xFFFF8A2A);
    const onSecondary = Color(0xFFFFFFFF);
    const secondaryContainer = Color(0xFFFFCC99);
    const onSecondaryContainer = Color(0xFF5B2500);

    const tertiary = Color(0xFFFFB300);
    const onTertiary = Color(0xFF3B2500);
    const tertiaryContainer = Color(0xFFFFE0A3);
    const onTertiaryContainer = Color(0xFF3B2500);

    const surface = Color(0xFFFFFBF7);
    const onSurface = Color(0xFF2A160B);

    const outline = Color(0xFFC8794E);
    const outlineVariant = Color(0xFFE29A75);

    const inverseSurface = Color(0xFF2A160B);
    const inversePrimary = primary;
    const surfaceTint = primary;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      surface: surface,
      onSurface: onSurface,
      outline: outline,
      outlineVariant: outlineVariant,
      inverseSurface: inverseSurface,
      inversePrimary: inversePrimary,
      surfaceTint: surfaceTint,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: FormBuilderLocalizations.localizationsDelegates,
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: colorScheme.onPrimary,
            backgroundColor: colorScheme.primary,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.primary,
            side: BorderSide(color: colorScheme.primary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.65),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
        ),
      ),
      home: const HomePage(title: 'Flutter Demo'),
    );
  }
}
