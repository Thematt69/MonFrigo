import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../blocs/bloc_provider.dart';
import '../blocs/firebase_auth_bloc.dart';
import '../routes/router.dart';
import '../widgets/app_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 3,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mon profil :',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Text('Modifier mon profil et mes paramètres'),
          const Text('Supprimer mon compte'),
          const Text('Se déconnecter'),
          ElevatedButton.icon(
            onPressed: () async {
              await BlocProvider.of<FirebaseAuthBloc>(context)
                  .signOut()
                  .then((_) => context.goNamed(AppRoute.signIn.name));
            },
            icon: const Icon(Icons.logout_outlined),
            label: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
  }
}
