import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/generic_product.dart';
import 'bloc_provider.dart';

class FirebaseStoreBloc extends BlocBase {
  final CollectionReference<GenericProduct> _genericProductsCollection =
      FirebaseFirestore.instance
          .collection(GenericProduct.collectionName)
          .withConverter<GenericProduct>(
            fromFirestore: (snapshot, _) =>
                GenericProduct.fromFirestore(snapshot.data()!),
            toFirestore: (product, _) => product.toFirestore(),
          );

  Stream<List<GenericProduct>> get onGenericProductsChange =>
      _genericProductsCollection
          .orderBy(GenericProduct.entryName)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  @override
  void dispose() {}

  @override
  void initState() {}
}
