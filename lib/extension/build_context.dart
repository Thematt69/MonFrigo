import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void showErrorSnackBar(String exception) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(this).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(
                Icons.warning_amber,
                color: Theme.of(this).colorScheme.onError,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  exception,
                  style: Theme.of(this).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(this).colorScheme.onError,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  void showMessagingSnackBar({
    required String title,
    required String body,
    required VoidCallback onPressed,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(this).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Afficher',
            onPressed: () {
              onPressed();
              ScaffoldMessenger.of(this).hideCurrentSnackBar();
            },
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: Theme.of(this).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(this).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(this).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: Theme.of(this).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(this).colorScheme.onPrimary,
                    ),
              ),
            ],
          ),
        ),
      );
  }
}
