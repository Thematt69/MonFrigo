import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/bloc_provider.dart';
import '../../blocs/firebase_auth_bloc.dart';
import '../../extension/build_context.dart';
import '../../routes/router.dart';
import '../../widgets/app_scaffold.dart';
import 'delete_user_dialog.dart';
import 'sign_out_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 3,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Modifier mon profil et mes paramètres'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await showGeneralDialog<bool>(
                  context: context,
                  pageBuilder: (context, _, __) => const DeleteUserDialog(),
                ).then((result) async {
                  if (result ?? false) {
                    await BlocProvider.of<FirebaseAuthBloc>(context)
                        .deleteCurrentUser()
                        .then((result) {
                      result.match(
                        (_) => context.goNamed(AppRoute.signIn.name),
                        (exception) => context.showErrorSnackBar(exception),
                      );
                    });
                  }
                });
              },
              child: const Text('Supprimer mon compte'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                await showGeneralDialog<bool>(
                  context: context,
                  pageBuilder: (context, _, __) => const SignOutDialog(),
                ).then((result) async {
                  if (result ?? false) {
                    await BlocProvider.of<FirebaseAuthBloc>(context)
                        .signOut()
                        .then((result) {
                      result.match(
                        (_) => context.goNamed(AppRoute.signIn.name),
                        (exception) => context.showErrorSnackBar(exception),
                      );
                    });
                  }
                });
              },
              icon: const Icon(Icons.logout_outlined),
              label: const Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
