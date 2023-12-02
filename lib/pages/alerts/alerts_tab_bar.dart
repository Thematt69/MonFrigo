import 'package:flutter/material.dart';

import '../../mock_values.dart';

class AlertsTabBar extends StatefulWidget {
  const AlertsTabBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<AlertsTabBar> createState() => _AlertsTabBarState();
}

class _AlertsTabBarState extends State<AlertsTabBar> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      tabs: [
        const Tab(text: 'Toutes'),
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Non-lus'),
              const SizedBox(width: 8),
              Badge(
                label: Text(
                  alertsMock.where((alert) => !alert.isRead).length.toString(),
                ),
              ),
            ],
          ),
        ),
        const Tab(text: 'Lus'),
      ],
    );
  }
}
