import 'package:flutter/material.dart';

import '../extension/build_context.dart';
import '../widgets/app_scaffold.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ma liste de courses :',
            style: context.textTheme.titleMedium,
          ),
          const Text('Visualiser la liste'),
          const Text('Suggérer les produits en faible quantité'),
          const Text('Ajouter des produits '),
          const Text("Modifier la quantité d'un produit"),
          const Text('Supprimer des produits'),
          const Text('Cocher un produit'),
          const Text('Vider'),
        ],
      ),
    );
  }
}
