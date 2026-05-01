import 'package:flutter/material.dart';

/// Shows a generic confirmation dialog. Returns `true` if the user confirms,
/// `false` if they cancel, or `null` if the route is popped without a result.
Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String title,
  required Widget content,
  required String confirmLabel,
  required String cancelLabel,
  bool confirmIsDestructive = false,
  bool barrierDismissible = true,
}) {
  final theme = Theme.of(context);
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelLabel),
          ),
          TextButton(
            style: confirmIsDestructive
                ? TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  )
                : null,
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  );
}
