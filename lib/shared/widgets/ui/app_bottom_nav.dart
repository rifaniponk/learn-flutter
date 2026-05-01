import 'package:flutter/material.dart';

import '../../../app/tokens.dart';

/// One item in [AppBottomNav].
class AppBottomNavItem {
  const AppBottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// A floating, pill-shaped bottom navigation bar.
///
/// Distinctive design choices:
///   - Floats above the bottom edge with safe-area padding.
///   - Stadium-shaped with a warm shadow underneath.
///   - The selected item gets a rounded "pill" highlight that animates
///     between positions — much more characterful than the standard
///     Material indicator.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // The bar must have a bounded height — Scaffold.bottomNavigationBar
    // does not impose one, so without this the Row's Expanded children
    // grow to fill the whole screen.
    const barHeight = 64.0;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppTokens.space4,
          0,
          AppTokens.space4,
          AppTokens.space3,
        ),
        child: SizedBox(
          height: barHeight,
          child: Container(
            decoration: ShapeDecoration(
              color: scheme.surfaceContainerLowest,
              shape: const StadiumBorder(),
              shadows: AppTokens.shadowLg,
            ),
            padding: const EdgeInsets.all(AppTokens.space2),
            child: Row(
              children: List.generate(items.length, (i) {
                final item = items[i];
                final selected = i == currentIndex;
                return Expanded(
                  child: _NavItem(
                    item: item,
                    selected: selected,
                    textStyle: textTheme.labelSmall,
                    onTap: () => onTap(i),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.selected,
    required this.textStyle,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool selected;
  final TextStyle? textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      // Center so the pill sizes to its child rather than stretching
      // to fill the Expanded cell.
      child: Center(
        child: AnimatedContainer(
          duration: AppTokens.durationMed,
          curve: AppTokens.curveStandard,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.space3,
            vertical: AppTokens.space2,
          ),
          decoration: ShapeDecoration(
            color: selected ? scheme.primary : Colors.transparent,
            shape: const StadiumBorder(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: AppTokens.durationFast,
                child: Icon(
                  selected ? item.activeIcon : item.icon,
                  key: ValueKey(selected),
                  size: 22,
                  color: selected ? scheme.onPrimary : AppTokens.ink500,
                ),
              ),
              // Show the label only when selected — keeps icons tidy and
              // gives the active item more visual weight.
              ClipRect(
                child: AnimatedAlign(
                  duration: AppTokens.durationMed,
                  curve: AppTokens.curveStandard,
                  widthFactor: selected ? 1.0 : 0.0,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppTokens.space2),
                    child: Text(
                      item.label,
                      style: textStyle?.copyWith(
                        color: scheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
