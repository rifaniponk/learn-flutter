import 'package:flutter/material.dart';

import 'ui/app_card.dart';

/// Backwards-compatible shim around the new [AppCard].
///
/// The old `ReusableContainer` API is preserved so any existing feature
/// pages keep working — but visually it now follows the new design
/// language (squircle corners, warm shadow, white surface).
///
/// Prefer using [AppCard] directly in new code.
@Deprecated('Use AppCard from shared/widgets/ui/ui.dart instead.')
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: AppCard(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
