import 'package:flutter/material.dart';

import '../blocs/bloc_provider.dart';
import '../blocs/firebase_store_bloc.dart';
import '../extension/build_context.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/custom_builder.dart';

class FridgePage extends StatelessWidget {
  const FridgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 0,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
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
            const SizedBox(height: 16),
            Text(
              'Liste des produits :',
              style: context.textTheme.titleMedium,
            ),
            CustomStreamBuilder(
              stream: BlocProvider.of<FirebaseStoreBloc>(context)
                  .onGenericProductsChange,
              dataBuilder: (context, data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final product = data[index];
                    return ListTile(
                      leading: Icon(product.icon),
                      title: Text(product.name),
                      subtitle: product.description == null
                          ? null
                          : Text(product.description!),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
