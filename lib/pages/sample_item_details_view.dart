import 'package:flutter/material.dart';

import '../blocs/bloc_provider.dart';
import '../blocs/firebase_auth_bloc.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<FirebaseAuthBloc>(context)
                    .createUserWithEmailAndPassword(
                  email: 'devilliers.matthieu@gmail.com',
                  password: '123456789!',
                );
              },
              child: const Text('Créer un compte'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<FirebaseAuthBloc>(context)
                    .signInWithEmailAndPassword(
                  email: 'devilliers.matthieu@gmail.com',
                  password: '123456789!',
                );
              },
              child: const Text('Connexion à un compte'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<FirebaseAuthBloc>(context).signInWithGoogle();
              },
              child: const Text('Connexion à un compte via Google'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<FirebaseAuthBloc>(context).signOut();
              },
              child: const Text('Déconnexion'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<FirebaseAuthBloc>(context).deleteCurrentUser();
              },
              child: const Text('Supprimer le compte'),
            ),
          ],
        ),
      ),
    );
  }
}
