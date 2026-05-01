import 'package:flutter/material.dart';

import '../../../app/tokens.dart';

/// Visual variant of [AppCard].
enum AppCardVariant {
  /// White card with a soft warm shadow. The default.
  elevated,

  /// Cream-tinted card with no shadow, sitting on the background.
  flat,

  /// Highlighted card with a soft orange tint — for spotlighted items.
  accent,
}

/// A signature card. Squircle (continuous) corners + warm tinted shadow.
///
/// The continuous border radius is what makes the card look intentional
/// rather than "default Flutter" — it's the same curve iOS uses for app
/// icons. Pair with the warm shadow tokens for a cohesive feel.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.elevated,
    this.padding = const EdgeInsets.all(AppTokens.space5),
    this.onTap,
    this.borderRadius = AppTokens.radiusXl,
  });

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final (bg, shadow) = switch (variant) {
      AppCardVariant.elevated => (
          scheme.surfaceContainerLowest,
          AppTokens.shadowMd,
        ),
      AppCardVariant.flat => (
          scheme.surfaceContainer,
          const <BoxShadow>[],
        ),
      AppCardVariant.accent => (
          AppTokens.orange50,
          AppTokens.shadowSm,
        ),
    };

    final shape = ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    Widget content = Container(
      padding: padding,
      decoration: ShapeDecoration(
        color: bg,
        shape: shape,
        shadows: shadow,
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: shape,
          splashColor: scheme.primary.withValues(alpha: 0.06),
          highlightColor: Colors.transparent,
          child: content,
        ),
      );
    }

    return content;
  }
}
