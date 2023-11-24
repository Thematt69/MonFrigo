import 'package:flutter/material.dart';

import '../utils/app_breakpoint.dart';

extension BuildContextExtension on BuildContext {
  /// Extension on ThemeData
  ThemeData get theme => Theme.of(this);

  /// Extension on TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Extension on ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Extension on MediaQueryData
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Extension on ScaffoldMessengerState
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Extension to check if the app run on mobile
  bool get isOnMobile => AppBreakpoint.isSmall(mediaQuery.size.width);

  /// Extension to check if the app run on small mobile
  bool get isOnTablet => AppBreakpoint.isMedium(mediaQuery.size.width);

  /// Extension to check if the app run on small mobile
  bool get isOnDesktop => AppBreakpoint.isLarge(mediaQuery.size.width);

  void showErrorSnackBar(String exception) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.error,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              Icon(
                Icons.warning_amber,
                color: colorScheme.onError,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  exception,
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onError,
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
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Afficher',
            onPressed: () {
              onPressed();
              scaffoldMessenger.hideCurrentSnackBar();
            },
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      title,
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
