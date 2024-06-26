import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mon_frigo/mock_values.dart';
import 'package:mon_frigo/routes/router.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (int selectedIndex) {
        if (index == selectedIndex) return;
        switch (selectedIndex) {
          case 0:
            context.goNamed(AppRoute.fridge.name);
          case 1:
            context.goNamed(AppRoute.shoppingList.name);
          case 2:
            context.goNamed(AppRoute.alerts.name);
          case 3:
            context.goNamed(AppRoute.profile.name);
        }
      },
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.kitchen_outlined),
          selectedIcon: Icon(Icons.kitchen),
          label: 'Mon Frigo',
          tooltip: kIsWeb ? '' : null,
        ),
        const NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          selectedIcon: Icon(Icons.receipt_long),
          label: 'Ma liste',
          tooltip: kIsWeb ? '' : null,
        ),
        NavigationDestination(
          icon: Badge(
            label: Text(
              alertsMock.where((alert) => !alert.isRead).length.toString(),
            ),
            child: const Icon(Icons.notifications_outlined),
          ),
          selectedIcon: Badge(
            label: Text(
              alertsMock.where((alert) => !alert.isRead).length.toString(),
            ),
            child: const Icon(Icons.notifications),
          ),
          label: 'Mes alertes',
          tooltip: kIsWeb ? '' : null,
        ),
        const NavigationDestination(
          icon: Icon(Icons.account_circle_outlined),
          selectedIcon: Icon(Icons.account_circle),
          label: 'Mon profil',
          tooltip: kIsWeb ? '' : null,
        ),
      ],
    );
  }
}
