import 'package:flutter/material.dart';

import '../widgets/app_scaffold.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mes alertes :',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Text('Visualiser mes alertes'),
          const Text('Être averti des produits bientôt périmés'),
          const Text('Être averti des produits périmés'),
        ],
      ),
    );
  }
}
