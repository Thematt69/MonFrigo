import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mon_frigo/blocs/bloc_provider.dart';
import 'package:mon_frigo/blocs/firebase_auth_bloc.dart';
import 'package:mon_frigo/extension/build_context.dart';
import 'package:mon_frigo/pages/profile/delete_user_dialog.dart';
import 'package:mon_frigo/pages/profile/sign_out_dialog.dart';
import 'package:mon_frigo/routes/router.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mes paramètres',
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
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
          icon: const Icon(Icons.delete_outlined),
          label: const Text('Supprimer mon compte'),
        ),
        const SizedBox(height: 8),
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
    );
  }
}
