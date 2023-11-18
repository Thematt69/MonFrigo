import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

extension ObjectExtension on Object {
  void logException(
    StackTrace stackTrace,
    String name,
  ) {
    log(
      'Erreur capturée : $this',
      error: this,
      stackTrace: stackTrace,
      name: name,
    );
    FirebaseCrashlytics.instance.recordError(
      this,
      stackTrace,
      reason: 'Erreur capturée : $this',
    );
  }
}

extension FirebaseAuthExceptionExtension on FirebaseAuthException {
  void logException(StackTrace stackTrace, String location) {
    late final String message;
    switch (code) {
      case 'provider-already-linked':
        message = 'The provider has already been linked to the user.';
        break;
      case 'invalid-credential':
        message = "The provider's credential is not valid.";
        break;
      case 'credential-already-in-use':
        message = 'The account corresponding to the credential already exists, '
            'or is already linked to a Firebase User.';
        break;
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided for that user.';
        break;
      case 'weak-password':
        message = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        message = 'The account already exists for that email.';
        break;
      default:
        message = 'Failed with error code: $code';
        break;
    }
    log(
      message,
      error: this,
      stackTrace: stackTrace,
      name: location,
    );
    FirebaseCrashlytics.instance.recordError(
      this,
      stackTrace,
      reason: message,
    );
  }
}

extension FirebaseExceptionExtension on FirebaseException {
  void logException(StackTrace stackTrace, String location) {
    late final String message;
    switch (code) {
      case 'storage/object-not-found':
        message = 'No object exists at the desired reference.';
        break;
      case 'storage/bucket-not-found':
        message = 'No bucket is configured for Firebase Storage.';
        break;
      case 'storage/project-not-found':
        message = 'No project is configured for Firebase Storage.';
        break;
      case 'storage/quota-exceeded':
        message =
            "Quota on your Cloud Storage bucket has been exceeded. If you're on the no-cost tier, upgrade to a paid plan. If you're on a paid plan, reach out to Firebase support.";
        break;
      case 'storage/unauthenticated':
        message = 'User is unauthenticated, please authenticate and try again.';
        break;
      case 'storage/unauthorized':
        message =
            'User is not authorized to perform the desired action, check your security rules to ensure they are correct.';
        break;
      case 'storage/retry-limit-exceeded':
        message =
            'The maximum time limit on an operation (upload, download, delete, etc.) has been exceeded. Try uploading again.';
        break;
      case 'storage/invalid-checksum':
        message =
            'File on the client does not match the checksum of the file received by the server. Try uploading again.';
        break;
      case 'storage/canceled':
        message = 'User canceled the operation.';
        break;
      case 'storage/invalid-event-name':
        message =
            'Invalid event name provided. Must be one of [running, progress, pause]';
        break;
      case 'storage/invalid-url':
        message =
            'Invalid URL provided to refFromURL(). Must be of the form: gs://bucket/object or https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>';
        break;
      case 'storage/invalid-argument':
        message =
            'The argument passed to put() must be File, Blob, or UInt8 Array. The argument passed to putString() must be a raw, Base64, or Base64URL string.';
        break;
      case 'storage/no-default-bucket':
        message =
            "No bucket has been set in your config's storageBucket property.";
        break;
      case 'storage/cannot-slice-blob':
        message =
            "Commonly occurs when the local file has changed (deleted, saved again, etc.). Try uploading again after verifying that the file hasn't changed.";
        break;
      case 'storage/server-file-wrong-size':
        message =
            'File on the client does not match the size of the file recieved by the server. Try uploading again.';
        break;
      default:
        message = 'Failed with error code: $code';
        break;
    }
    log(
      message,
      error: this,
      stackTrace: stackTrace,
      name: location,
    );
    FirebaseCrashlytics.instance.recordError(
      this,
      stackTrace,
      reason: message,
    );
  }
}
