import 'package:flutter/material.dart';

/// Design tokens — the foundational vocabulary of the app's UI.
///
/// Everything visual (theme + custom widgets) pulls values from here.
/// Change a token here and the entire app shifts consistently.
///
/// Why a tokens file (rather than scattering magic numbers): a single
/// source of truth keeps the design feeling intentional and lets you
/// re-skin the whole app by editing one file.
class AppTokens {
  const AppTokens._();

  // ---------------------------------------------------------------------------
  // Brand palette
  // ---------------------------------------------------------------------------
  // Warm "sunset" palette. Orange is the headliner; the supporting colors
  // were chosen to harmonize without competing.

  static const orange50 = Color(0xFFFFF4EC);
  static const orange100 = Color(0xFFFFE2CC);
  static const orange200 = Color(0xFFFFC59A);
  static const orange300 = Color(0xFFFFA467);
  static const orange400 = Color(0xFFF98538);
  static const orange500 = Color(0xFFF26A1B); // signature brand
  static const orange600 = Color(0xFFD9520A);
  static const orange700 = Color(0xFFA83D04);
  static const orange800 = Color(0xFF7A2C03);
  static const orange900 = Color(0xFF4A1E00);

  // Warm neutrals — not pure gray. A whisper of orange in the grays
  // makes the whole UI feel cohesive instead of bolted-on.
  static const ink900 = Color(0xFF1F1410); // primary text
  static const ink700 = Color(0xFF4A332A); // secondary text
  static const ink500 = Color(0xFF8B6F60); // tertiary / muted
  static const ink300 = Color(0xFFCBB5A6); // disabled / placeholder
  static const ink100 = Color(0xFFEBDFD5); // subtle borders
  static const ink50 = Color(0xFFF7F0EA); // surface tint

  static const cream = Color(0xFFFFFBF7); // page background
  static const white = Color(0xFFFFFFFF);

  // Functional colors (kept warm to match the family)
  static const success = Color(0xFF3FB67E);
  static const successDark = Color(0xFF2A8059);
  static const warning = Color(0xFFFFB300);
  static const danger = Color(0xFFE05550);
  static const dangerDark = Color(0xFFB23A36);

  // ---------------------------------------------------------------------------
  // Spacing scale (4pt grid)
  // ---------------------------------------------------------------------------

  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 20;
  static const double space6 = 24;
  static const double space8 = 32;
  static const double space10 = 40;
  static const double space12 = 48;
  static const double space16 = 64;

  // ---------------------------------------------------------------------------
  // Radii (squircle-friendly)
  // ---------------------------------------------------------------------------
  // We lean on slightly larger-than-Material radii to sell the soft feel.
  // Use ContinuousRectangleBorder for that smooth iOS-app-icon curve when
  // a shape is large enough to show the difference (cards, sheets).

  static const double radiusXs = 8;
  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 20;
  static const double radiusXl = 28;
  static const double radius2xl = 36;
  static const double radiusFull = 999;

  // ---------------------------------------------------------------------------
  // Signature shadows
  // ---------------------------------------------------------------------------
  // We use *warm* shadows (tinted with orange-brown) instead of pure black,
  // so depth still feels cohesive with the palette. Pure black shadows are
  // the #1 thing that makes a custom UI feel cheap.

  static List<BoxShadow> shadowSm = [
    BoxShadow(
      color: orange900.withValues(alpha: 0.06),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> shadowMd = [
    BoxShadow(
      color: orange900.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: orange900.withValues(alpha: 0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> shadowLg = [
    BoxShadow(
      color: orange900.withValues(alpha: 0.10),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: orange900.withValues(alpha: 0.06),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  /// "Pressable" shadow — a hard, offset block of color underneath an
  /// element, like the bottom face of a 3D button. This is what gives
  /// our buttons their tactile, satisfying-to-press feel.
  static List<BoxShadow> shadowPressable(Color color) => [
        BoxShadow(
          color: color,
          blurRadius: 0,
          offset: const Offset(0, 4),
        ),
      ];

  // ---------------------------------------------------------------------------
  // Animation
  // ---------------------------------------------------------------------------

  static const Duration durationFast = Duration(milliseconds: 120);
  static const Duration durationMed = Duration(milliseconds: 220);
  static const Duration durationSlow = Duration(milliseconds: 360);

  /// Slightly bouncy curve for "friendly" interactions. Use sparingly —
  /// overdone, it feels gimmicky.
  static const Curve curveBouncy = Curves.easeOutBack;
  static const Curve curveStandard = Curves.easeOutCubic;
}
