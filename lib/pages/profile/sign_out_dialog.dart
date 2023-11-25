import 'package:flutter/material.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Se déconnecter'),
      content: const Text(
        'Êtes-vous sûr de vouloir vous déconnecter ?',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Se déconnecter'),
        ),
      ],
    );
  }
}
