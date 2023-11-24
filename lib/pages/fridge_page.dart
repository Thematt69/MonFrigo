import 'package:flutter/material.dart';

import '../extension/build_context.dart';
import '../widgets/app_scaffold.dart';

class FridgePage extends StatelessWidget {
  const FridgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 0,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mon frigo :',
            style: context.textTheme.titleMedium,
          ),
          const Text('Visualiser les produits'),
          const Text('Ajouter des produits'),
          const Text("Modifier la quantité d'un produit"),
          const Text('Supprimer des produits'),
        ],
      ),
    );
  }
}
