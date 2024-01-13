import 'dart:async';

import 'package:flutter/material.dart';

import '../../blocs/bloc_provider.dart';
import '../../blocs/firebase_store_bloc.dart';
import '../../extension/build_context.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/custom_builder.dart';

class FridgePage extends StatefulWidget {
  const FridgePage({super.key});

  @override
  State<FridgePage> createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  final _searchController = ValueNotifier<String>('');
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

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
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: _searchController,
              builder: (context, value, _) => TextFormField(
                initialValue: value,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 200), () {
                    _searchController.value = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Rechercher un produit',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            CustomStreamBuilder(
              stream: BlocProvider.of<FirebaseStoreBloc>(context)
                  .onGenericProductsChange,
              waitingBuilder: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
              dataBuilder: (context, data) {
                return ValueListenableBuilder(
                  valueListenable: _searchController,
                  builder: (context, searchValue, _) {
                    final genericProducts = data
                        .where(
                          (e) => e.name.contains(
                            RegExp(searchValue, caseSensitive: false),
                          ),
                        )
                        .toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: genericProducts.length,
                      itemBuilder: (context, index) {
                        final product = genericProducts[index];
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
