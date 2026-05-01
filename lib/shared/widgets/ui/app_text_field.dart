import 'package:flutter/material.dart';

import '../../../app/tokens.dart';

/// Pill-shaped text field. Uses the global `inputDecorationTheme` from
/// `theme.dart` plus a label rendered above (instead of as a floating
/// Material label, which is one of the strongest "Material UI" tells).
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.autovalidateMode,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(
              left: AppTokens.space4,
              bottom: AppTokens.space2,
            ),
            child: Text(
              label!,
              style: textTheme.labelMedium?.copyWith(color: AppTokens.ink700),
            ),
          ),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          autovalidateMode:
              autovalidateMode ?? AutovalidateMode.disabled,
          maxLines: obscureText ? 1 : maxLines,
          enabled: enabled,
          autofocus: autofocus,
          style: textTheme.bodyLarge,
          cursorColor: scheme.primary,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            helperText: helperText,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: AppTokens.space4),
                    child: Icon(prefixIcon, color: AppTokens.ink500, size: 20),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 24,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
