import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/sample_item.dart';
import '../routes/router.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text('SampleItem ${item.id}'),
            leading: const CircleAvatar(
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            onTap: () => context.goNamed(AppRoute.sampleItemDetailsView.name),
          );
        },
      ),
    );
  }
}
