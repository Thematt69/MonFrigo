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
}
