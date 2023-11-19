import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../blocs/bloc_provider.dart';
import '../blocs/firebase_auth_bloc.dart';
import '../routes/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page d'accueil"),
        actions: [
          IconButton(
            onPressed: () async {
              await BlocProvider.of<FirebaseAuthBloc>(context)
                  .signOut()
                  .then((_) => context.goNamed(AppRoute.signIn.name));
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mon frigo :',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text('Visualiser les produits'),
            const Text('Ajouter des produits'),
            const Text("Modifier la quantité d'un produit"),
            const Text('Supprimer des produits'),
            const SizedBox(height: 16),
            Text(
              'Ma liste de courses :',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text('Visualiser la liste'),
            const Text('Suggérer les produits en faible quantité'),
            const Text('Ajouter des produits '),
            const Text("Modifier la quantité d'un produit"),
            const Text('Supprimer des produits'),
            const Text('Cocher un produit'),
            const Text('Vider'),
            const SizedBox(height: 16),
            Text(
              'Mes alertes :',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text('Visualiser mes alertes'),
            const Text('Être averti des produits bientôt périmés'),
            const Text('Être averti des produits périmés'),
            const SizedBox(height: 16),
            Text(
              'Mon profil :',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text('Modifier mon profil et mes paramètres'),
            const Text('Supprimer mon compte'),
            const Text('Se déconnecter'),
          ],
        ),
      ),
    );
  }
}
