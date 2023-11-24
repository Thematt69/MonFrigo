import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/router.dart';

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
        switch (selectedIndex) {
          case 0:
            context.goNamed(AppRoute.fridge.name);
            break;
          case 1:
            context.goNamed(AppRoute.shoppingList.name);
            break;
          case 2:
            context.goNamed(AppRoute.alerts.name);
            break;
          case 3:
            context.goNamed(AppRoute.profile.name);
            break;
        }
      },
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.kitchen_outlined),
          selectedIcon: Icon(Icons.kitchen),
          label: Text('Mon Frigo'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.receipt_long_outlined),
          selectedIcon: Icon(Icons.receipt_long),
          label: Text('Ma liste'),
        ),
        NavigationRailDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.notifications_outlined),
          ),
          selectedIcon: Badge(
            label: Text('2'),
            child: Icon(Icons.notifications),
          ),
          label: Text('Mes alertes'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.account_circle_outlined),
          selectedIcon: Icon(Icons.account_circle),
          label: Text('Mon profil'),
        ),
      ],
    );
  }
}