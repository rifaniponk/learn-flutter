import 'package:flutter/material.dart';

import '../../../app/tokens.dart';

/// A small pill-shaped tag/chip — for status indicators, categories,
/// filters, etc. Always stadium-shaped, never rectangular.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.foregroundColor,
    this.onTap,
    this.selected = false,
  });

  /// Convenience constructor for a "soft" / tinted accent chip.
  const AppChip.accent({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.selected = false,
  })  : color = AppTokens.orange100,
        foregroundColor = AppTokens.orange900;

  /// Convenience constructor for a success / "good" chip.
  const AppChip.success({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.selected = false,
  })  : color = const Color(0xFFD7F0E2),
        foregroundColor = AppTokens.successDark;

  final String label;
  final IconData? icon;
  final Color? color;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bg = color ??
        (selected ? scheme.primary : scheme.surfaceContainer);
    final fg = foregroundColor ??
        (selected ? scheme.onPrimary : scheme.onSurface);

    final content = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.space3,
        vertical: AppTokens.space2,
      ),
      decoration: ShapeDecoration(
        color: bg,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: AppTokens.space1),
          ],
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return content;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: content,
    );
  }
}
