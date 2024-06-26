import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mon_frigo/mock_values.dart';
import 'package:mon_frigo/routes/router.dart';

class AppNavigationRail extends StatelessWidget {
  const AppNavigationRail({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: index,
      labelType: NavigationRailLabelType.all,
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
        const NavigationRailDestination(
          icon: Icon(Icons.kitchen_outlined),
          selectedIcon: Icon(Icons.kitchen),
          label: Text('Mon Frigo'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.receipt_long_outlined),
          selectedIcon: Icon(Icons.receipt_long),
          label: Text('Ma liste'),
        ),
        NavigationRailDestination(
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
          label: const Text('Mes alertes'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.account_circle_outlined),
          selectedIcon: Icon(Icons.account_circle),
          label: Text('Mon profil'),
        ),
      ],
    );
  }
}
