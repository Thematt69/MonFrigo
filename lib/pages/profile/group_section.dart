import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mon_frigo/blocs/bloc_provider.dart';
import 'package:mon_frigo/blocs/firebase_auth_bloc.dart';
import 'package:mon_frigo/extension/build_context.dart';
import 'package:mon_frigo/mock_values.dart';
import 'package:mon_frigo/models/group.dart';
import 'package:share_plus/share_plus.dart';

class GroupSection extends StatefulWidget {
  const GroupSection({super.key});

  @override
  State<GroupSection> createState() => _GroupSectionState();
}

class _GroupSectionState extends State<GroupSection> {
  late final _authBloc = BlocProvider.of<FirebaseAuthBloc>(context);
  late final Group? group;

  @override
  void initState() {
    final userUuid = _authBloc.currentUser?.uid;
    if (userUuid != null) {
      group = groupsMock
          .firstWhereOrNull((group) => group.usersUuid.contains(userUuid));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mon groupe',
          style: context.textTheme.titleLarge,
        ),
        if (group != null) ...[
          const SizedBox(height: 16),
          Text(
            group!.name,
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Membres : ${group!.usersUuid.length} personnes',
            style: context.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              Share.share(
                'Salut ! 👋'
                "\nPrêt pour rejoindre mon groupe sur l'application Mon frigo ?"
                '\n\nVoici le code à rentrer : ${group!.codeShare}'
                '\n\nSur Android : https://bit.ly/appMonFrigo'
                '\nSur ordinateur : http://bit.ly/monFrigo',
                subject: 'Rejoins mon groupe sur Mon frigo !',
              );
            },
            icon: const Icon(Icons.share_outlined),
            label: const Text('Inviter des membres'),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              // TODO(Matthieu): quit group
            },
            icon: const Icon(Icons.exit_to_app_outlined),
            label: const Text('Quitter le groupe'),
          ),
        ] else ...[
          const SizedBox(height: 16),
          Text(
            "Vous n'avez pas encore rejoint de groupe",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Code de partage',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // TODO(Matthieu): join group
                      }
                    },
                    icon: const Icon(Icons.check_outlined),
                  ),
                ),
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un code de partage';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}
