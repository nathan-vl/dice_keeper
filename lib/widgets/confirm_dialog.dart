import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String message, confirmText;
  final void Function() onConfirm;

  const ConfirmDialog({
    super.key,
    required this.message,
    required this.confirmText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                FilledButton(
                  onPressed: onConfirm,
                  child: Text(confirmText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
