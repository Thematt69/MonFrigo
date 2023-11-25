import 'package:flutter/material.dart';

import '../../extension/build_context.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Supprimer mon compte'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Êtes-vous sûr de vouloir supprimer votre compte ?',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Cette action est irréversible, vous ne pourrez pas récupérer '
            'votre compte et toutes vos données seront supprimées.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Supprimer mon compte'),
        ),
      ],
    );
  }
}
