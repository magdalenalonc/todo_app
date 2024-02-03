import 'package:flutter/material.dart';

class ToDoEntryItemError extends StatelessWidget {
  const ToDoEntryItemError({
    super.key,
    required this.handleRetry,
  });

  final Function() handleRetry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: handleRetry,
      leading: const Icon(Icons.warning_rounded),
      title: const Text('Error loading entry. Click or tap to retry.'),
    );
  }
}
