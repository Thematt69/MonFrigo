import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mon_frigo/blocs/bloc_provider.dart';
import 'package:mon_frigo/extension/exception.dart';

class FirebaseStorageBloc extends BlocBase {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> getDownloadUrl(String name) async {
    try {
      final downloadURL = await _storage.ref(name).getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseStorageBloc | getDownloadUrl');
    } catch (e, s) {
      e.logException(s, 'FirebaseStorageBloc | getDownloadUrl');
    }
    return null;
  }

  Future<String?> openFilePicker() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result?.files.single.bytes != null) {
        final Uint8List fileBytes = result!.files.first.bytes!;
        final String fileName = result.files.first.name;

        await _uploadFile(fileBytes, fileName);

        return fileName;
      }
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseStorageBloc | openFilePicker');
    } catch (e, s) {
      e.logException(s, 'FirebaseStorageBloc | openFilePicker');
    }
    return null;
  }

  Future<void> _uploadFile(Uint8List fileBytes, String fileName) async {
    try {
      final SettableMetadata metadata = SettableMetadata(
        cacheControl: 'max-age=172800', // 2 jours
        customMetadata: <String, String>{
          'userUid': FirebaseAuth.instance.currentUser?.uid ?? 'N/A',
        },
      );
      await _storage.ref().child(fileName).putData(fileBytes, metadata);
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseStorageBloc | uploadFile');
    } catch (e, s) {
      e.logException(s, 'FirebaseStorageBloc | uploadFile');
    }
  }

  Future<void> deleteImage(String fileName) async {
    try {
      await _storage.ref().child(fileName).delete();
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseStorageBloc | deleteImage');
    } catch (e, s) {
      e.logException(s, 'FirebaseStorageBloc | deleteImage');
    }
  }

  @override
  void dispose() {}

  @override
  void initState() {}
}
