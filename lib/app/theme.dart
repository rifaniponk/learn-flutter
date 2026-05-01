import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tokens.dart';

/// The app's theme — built around the design tokens in `tokens.dart`.
///
/// Aesthetic: soft, friendly, warm. Inspired by Duolingo / Headspace
/// but distinctly its own — squircle corners, warm-tinted shadows,
/// distinctive typography pairing (Bricolage Grotesque for display,
/// Manrope for body).
///
/// Cross-platform consistency:
///   - Same page transitions on iOS and Android.
///   - Material-style scrollbars and overscroll on every platform
///     (see `AppScrollBehavior` at the bottom of this file).
///   - Material text-selection handles forced on iOS.
///   - Avoid `*.adaptive` widgets in feature code.
class AppTheme {
  const AppTheme._();

  // ---------------------------------------------------------------------------
  // Typography — Bricolage Grotesque (display) + Manrope (body)
  // ---------------------------------------------------------------------------
  // The pairing is intentional: Bricolage has a quirky, slightly
  // hand-drawn personality that gives headings character; Manrope is
  // a clean, highly-readable workhorse for everything else.

  static TextTheme _textTheme() {
    final display = GoogleFonts.bricolageGrotesqueTextTheme();
    final body = GoogleFonts.manropeTextTheme();

    return TextTheme(
      // Display & headlines use Bricolage for personality.
      displayLarge: display.displayLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        height: 1.05,
        color: AppTokens.ink900,
      ),
      displayMedium: display.displayMedium?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        height: 1.1,
        color: AppTokens.ink900,
      ),
      displaySmall: display.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.15,
        color: AppTokens.ink900,
      ),
      headlineLarge: display.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppTokens.ink900,
      ),
      headlineMedium: display.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: AppTokens.ink900,
      ),
      headlineSmall: display.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTokens.ink900,
      ),

      // Titles bridge display & body — use Bricolage at heavier weights.
      titleLarge: display.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTokens.ink900,
      ),
      titleMedium: body.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTokens.ink900,
      ),
      titleSmall: body.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppTokens.ink700,
      ),

      // Body & labels use Manrope for readability.
      bodyLarge: body.bodyLarge?.copyWith(
        height: 1.5,
        color: AppTokens.ink900,
      ),
      bodyMedium: body.bodyMedium?.copyWith(
        height: 1.5,
        color: AppTokens.ink700,
      ),
      bodySmall: body.bodySmall?.copyWith(
        height: 1.5,
        color: AppTokens.ink500,
      ),
      labelLarge: body.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
      labelMedium: body.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      labelSmall: body.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ColorScheme — built from tokens
  // ---------------------------------------------------------------------------

  static final ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: AppTokens.orange500,
    onPrimary: AppTokens.white,
    primaryContainer: AppTokens.orange100,
    onPrimaryContainer: AppTokens.orange900,

    secondary: AppTokens.orange400,
    onSecondary: AppTokens.white,
    secondaryContainer: AppTokens.orange50,
    onSecondaryContainer: AppTokens.orange800,

    tertiary: AppTokens.warning,
    onTertiary: AppTokens.ink900,
    tertiaryContainer: const Color(0xFFFFE9B5),
    onTertiaryContainer: AppTokens.ink900,

    error: AppTokens.danger,
    onError: AppTokens.white,
    errorContainer: const Color(0xFFFFD9D7),
    onErrorContainer: AppTokens.dangerDark,

    surface: AppTokens.cream,
    onSurface: AppTokens.ink900,
    surfaceContainerLowest: AppTokens.white,
    surfaceContainerLow: AppTokens.cream,
    surfaceContainer: AppTokens.ink50,
    surfaceContainerHigh: AppTokens.ink50,
    surfaceContainerHighest: AppTokens.ink100,

    onSurfaceVariant: AppTokens.ink700,
    outline: AppTokens.ink300,
    outlineVariant: AppTokens.ink100,

    inverseSurface: AppTokens.ink900,
    onInverseSurface: AppTokens.cream,
    inversePrimary: AppTokens.orange300,
    surfaceTint: AppTokens.orange500,

    shadow: AppTokens.orange900,
    scrim: AppTokens.ink900,
  );

  // ---------------------------------------------------------------------------
  // ThemeData
  // ---------------------------------------------------------------------------

  static ThemeData get light => _build(lightColorScheme);

  static ThemeData _build(ColorScheme colorScheme) {
    final textTheme = _textTheme();

    // Same transition on every platform — see file header for why.
    const consistentTransitions = PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.windows: ZoomPageTransitionsBuilder(),
        TargetPlatform.linux: ZoomPageTransitionsBuilder(),
      },
    );

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      pageTransitionsTheme: consistentTransitions,
      textTheme: textTheme,

      // Splash & highlight tuned to feel less "Material ripple" and more
      // like a soft press. The standard Material ripple is one of the
      // strongest "this is a Flutter app" tells; muting it helps.
      splashFactory: InkSparkle.splashFactory,
      splashColor: colorScheme.primary.withValues(alpha: 0.08),
      highlightColor: Colors.transparent,

      // AppBar — flat, no shadow, no center alignment. Title gets the
      // display font for character.
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        toolbarHeight: 64,
      ),

      // Cards — squircle (continuous) corners, warm shadow, no border.
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppTokens.radiusXl)),
        ),
      ),

      // Buttons — note: the *real* button look is in AppButton, the
      // custom widget. These themes are fallbacks for any stock
      // ElevatedButton/OutlinedButton still in the codebase.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge,
          elevation: 0,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space4,
          ),
          minimumSize: const Size(0, 52),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: colorScheme.primary, width: 2),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space6,
            vertical: AppTokens.space4,
          ),
          minimumSize: const Size(0, 52),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space4,
            vertical: AppTokens.space2,
          ),
        ),
      ),

      // Inputs — pill-shaped, filled, no visible border at rest.
      // The stadium shape is what kills the "Material form field" look.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space5,
          vertical: AppTokens.space4,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppTokens.ink300),
        labelStyle: textTheme.bodyMedium?.copyWith(color: AppTokens.ink500),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppTokens.radiusFull)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppTokens.radiusFull)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppTokens.radiusFull),
          ),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppTokens.radiusFull),
          ),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppTokens.radiusFull),
          ),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
      ),

      // Dialogs — squircle, no Material elevation tint.
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        elevation: 0,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppTokens.radius2xl)),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),

      // Bottom sheets — pulled-up squircle.
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        elevation: 0,
        modalElevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTokens.radius2xl),
          ),
        ),
      ),

      // Snackbars — pill-shaped, ink-colored.
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: const StadiumBorder(),
        insetPadding: const EdgeInsets.all(AppTokens.space4),
      ),

      // Chips — soft, pill-shaped, no border.
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        labelStyle: textTheme.labelMedium?.copyWith(color: colorScheme.onSurface),
        side: BorderSide.none,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space3,
          vertical: AppTokens.space2,
        ),
      ),

      // Dividers — barely-there.
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: AppTokens.space4,
      ),

      // Scrollbars — match the warm palette.
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(
          AppTokens.ink500.withValues(alpha: 0.4),
        ),
        radius: const Radius.circular(AppTokens.radiusFull),
      ),

      // Text selection handles — Material on iOS too.
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withValues(alpha: 0.25),
        selectionHandleColor: colorScheme.primary,
      ),

      // Bottom nav theme — used by stock BottomNavigationBar if anyone
      // still uses it. We have a custom one in `app_bottom_nav.dart`.
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Progress indicators — orange, of course.
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        circularTrackColor: colorScheme.surfaceContainer,
      ),
    );
  }
}

/// Scroll behavior — uniform scrollbars and overscroll on every platform,
/// plus mouse/trackpad/stylus drag for desktop & web builds.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}
