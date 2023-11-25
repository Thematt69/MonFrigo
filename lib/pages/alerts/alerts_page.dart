import 'package:flutter/material.dart';

import '../../mock_values.dart';
import '../../models/alert.dart';
import '../../widgets/app_scaffold.dart';
import 'alert_tile.dart';
import 'alerts_filters.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Alert> get _allAlerts => alertsMock;
  List<Alert> get _unreadAlerts =>
      alertsMock.where((alert) => !alert.isRead).toList();
  List<Alert> get _readAlerts =>
      alertsMock.where((alert) => alert.isRead).toList();

  @override
  Widget build(BuildContext context) {
    _allAlerts.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    _unreadAlerts.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    _readAlerts.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return AppScaffold(
      index: 2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AlertsTabBar(
            tabController: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: _allAlerts.length,
                  itemBuilder: (context, index) {
                    final alert = _allAlerts[index];
                    return AlertTile(alert: alert);
                  },
                ),
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: _unreadAlerts.length,
                  itemBuilder: (context, index) {
                    final alert = _unreadAlerts[index];
                    return AlertTile(alert: alert);
                  },
                ),
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: _readAlerts.length,
                  itemBuilder: (context, index) {
                    final alert = _readAlerts[index];
                    return AlertTile(alert: alert);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
