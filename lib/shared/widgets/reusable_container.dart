import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  const ReusableContainer({
    super.key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final resolvedColor = color ?? colorScheme.surfaceContainerHighest;
    final resolvedBorderColor =
        colorScheme.outlineVariant.withValues(alpha: 0.9);

    return Container(
      width: double.infinity,
      height: 100,
      padding: padding,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.14),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
        color: resolvedColor,
        border: Border.all(
          color: resolvedBorderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
