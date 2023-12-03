import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../blocs/bloc_provider.dart';
import '../../blocs/firebase_storage_bloc.dart';
import '../../extension/build_context.dart';
import '../../mock_values.dart';
import '../../widgets/app_scaffold.dart';

class FridgePage extends StatefulWidget {
  const FridgePage({super.key});

  @override
  State<FridgePage> createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  static const double _bodyPaddingValue = 16;
  static const double _spacingValue = 8;
  static const double _borderValue = 8;

  double _widthRelativeToScreen(BuildContext context) {
    late int multiplicator;
    if (context.mediaQuery.size.width <= 650) {
      multiplicator = 2;
    } else if (context.mediaQuery.size.width <= 950) {
      multiplicator = 3;
    } else if (context.mediaQuery.size.width <= 1250) {
      multiplicator = 4;
    } else if (context.mediaQuery.size.width <= 1550) {
      multiplicator = 5;
    } else if (context.mediaQuery.size.width <= 1850) {
      multiplicator = 6;
    } else {
      multiplicator = 7;
    }

    return (context.mediaQuery.size.width -
            (_bodyPaddingValue * multiplicator) -
            (_borderValue * multiplicator) -
            (_spacingValue * (multiplicator - 1))) /
        multiplicator;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 0,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(_bodyPaddingValue),
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
            Wrap(
              spacing: _spacingValue,
              runSpacing: _spacingValue,
              children: fridgeProductsMock.map((product) {
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: context.colorScheme.outline),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: SizedBox(
                    width: _widthRelativeToScreen(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: FutureBuilder<String?>(
                            future:
                                BlocProvider.of<FirebaseStorageBloc>(context)
                                    .getDownloadUrl(product.uuid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                return CachedNetworkImage(
                                  width: _widthRelativeToScreen(context),
                                  height: _widthRelativeToScreen(context),
                                  imageUrl: snapshot.data!,
                                  progressIndicatorBuilder: (_, __, progress) =>
                                      Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (_, __, ___) => const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.remove_circle_outline_outlined,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '${product.number}',
                                      ),
                                      Text(
                                        '${product.number * product.quantity} ${product.unit.label}',
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.add_circle_outline_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // TODO: add expiration date chip
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
