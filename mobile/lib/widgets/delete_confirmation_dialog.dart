import 'package:flutter/material.dart';

Future<bool?> showDeleteConfirmationDialog(BuildContext context, String title) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete ebook?'),
      content: Text('Remove "$title" from your library?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
