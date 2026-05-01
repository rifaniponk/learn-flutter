import 'package:flutter/material.dart';

import '../../../app/tokens.dart';

/// Visual variant for [AppButton].
enum AppButtonVariant {
  /// Solid filled primary button — the headline call-to-action.
  primary,

  /// Lighter "tonal" fill — for secondary actions in the same area.
  soft,

  /// Outlined / ghost — for tertiary actions.
  outline,

  /// Destructive (red) — for delete/remove actions.
  danger,
}

/// Size scale for [AppButton]. Affects height, padding, and font size.
enum AppButtonSize { sm, md, lg }

/// The signature button of this app.
///
/// Visually distinctive features:
///   - Pill (stadium) shape — never rectangular.
///   - "Pressable" 3D effect: a hard-offset shadow strip below the button
///     that compresses when pressed, like a physical key.
///   - Custom press animation tuned for tactility.
///
/// This deliberately bypasses Material's `ElevatedButton` so we get
/// total control over the press behavior (and avoid the Material ripple,
/// which is a strong "this is a Flutter Material app" tell).
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.fullWidth = false,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool fullWidth;
  final bool loading;

  bool get _enabled => onPressed != null && !loading;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget._enabled) return;
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  ({Color background, Color foreground, Color shadow}) _palette(
    ColorScheme scheme,
  ) {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return (
          background: scheme.primary,
          foreground: scheme.onPrimary,
          shadow: AppTokens.orange700,
        );
      case AppButtonVariant.soft:
        return (
          background: AppTokens.orange100,
          foreground: AppTokens.orange900,
          shadow: AppTokens.orange200,
        );
      case AppButtonVariant.outline:
        return (
          background: scheme.surfaceContainerLowest,
          foreground: scheme.primary,
          shadow: AppTokens.ink100,
        );
      case AppButtonVariant.danger:
        return (
          background: AppTokens.danger,
          foreground: AppTokens.white,
          shadow: AppTokens.dangerDark,
        );
    }
  }

  ({double height, double padX, double iconSize, TextStyle text}) _sizing(
    TextTheme tt,
  ) {
    switch (widget.size) {
      case AppButtonSize.sm:
        return (
          height: 40,
          padX: AppTokens.space4,
          iconSize: 16,
          text: tt.labelMedium ?? const TextStyle(),
        );
      case AppButtonSize.md:
        return (
          height: 52,
          padX: AppTokens.space6,
          iconSize: 18,
          text: tt.labelLarge ?? const TextStyle(),
        );
      case AppButtonSize.lg:
        return (
          height: 60,
          padX: AppTokens.space8,
          iconSize: 20,
          text: (tt.labelLarge ?? const TextStyle()).copyWith(fontSize: 17),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final palette = _palette(scheme);
    final sizing = _sizing(Theme.of(context).textTheme);
    final enabled = widget._enabled;

    final isOutline = widget.variant == AppButtonVariant.outline;

    // The shadow "strip" depth — how tall the bottom face of the 3D
    // button looks. Compresses to zero when pressed.
    const restingDepth = 4.0;
    final depth = _pressed ? 0.0 : restingDepth;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.loading)
          SizedBox(
            width: sizing.iconSize,
            height: sizing.iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              valueColor: AlwaysStoppedAnimation(palette.foreground),
            ),
          )
        else if (widget.icon != null) ...[
          Icon(widget.icon, size: sizing.iconSize, color: palette.foreground),
          const SizedBox(width: AppTokens.space2),
        ],
        Flexible(
          child: Text(
            widget.label,
            style: sizing.text.copyWith(
              color: palette.foreground,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.trailingIcon != null && !widget.loading) ...[
          const SizedBox(width: AppTokens.space2),
          Icon(
            widget.trailingIcon,
            size: sizing.iconSize,
            color: palette.foreground,
          ),
        ],
      ],
    );

    final button = AnimatedContainer(
      duration: AppTokens.durationFast,
      curve: AppTokens.curveStandard,
      // Translate the button face down by `restingDepth - depth` so it
      // visually "compresses" into the shadow strip when pressed.
      transform: Matrix4.translationValues(0, restingDepth - depth, 0),
      height: sizing.height,
      padding: EdgeInsets.symmetric(horizontal: sizing.padX),
      decoration: ShapeDecoration(
        color: enabled
            ? palette.background
            : palette.background.withValues(alpha: 0.5),
        shape: StadiumBorder(
          side: isOutline
              ? BorderSide(
                  color: enabled
                      ? scheme.primary
                      : scheme.primary.withValues(alpha: 0.5),
                  width: 2,
                )
              : BorderSide.none,
        ),
      ),
      alignment: Alignment.center,
      child: content,
    );

    final stack = SizedBox(
      height: sizing.height + restingDepth,
      child: Stack(
        children: [
          // Bottom "shadow strip" — the floor the button presses into.
          if (enabled)
            Positioned.fill(
              child: AnimatedContainer(
                duration: AppTokens.durationFast,
                curve: AppTokens.curveStandard,
                margin: EdgeInsets.only(top: restingDepth - depth),
                decoration: ShapeDecoration(
                  color: palette.shadow,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          // The button face itself.
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: button,
          ),
        ],
      ),
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: MouseRegion(
        cursor:
            enabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          onTap: enabled ? widget.onPressed : null,
          child: widget.fullWidth
              ? SizedBox(width: double.infinity, child: stack)
              : IntrinsicWidth(child: stack),
        ),
      ),
    );
  }
}
