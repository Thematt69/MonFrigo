import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

extension ObjectExtension on Object {
  String logException(
    StackTrace stackTrace,
    String name,
  ) {
    // TODO: Add translation
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
    return 'Une erreur est survenue, veuillez réessayer ultérieurement';
  }
}

extension FirebaseAuthExceptionExtension on FirebaseAuthException {
  String logException(StackTrace stackTrace, String location) {
    // TODO: Add translation
    final message = switch (code) {
      ('provider-already-linked') =>
        'The provider has already been linked to the user.',
      ('invalid-credential') => "The provider's credential is not valid.",
      ('credential-already-in-use') =>
        'The account corresponding to the credential already exists, or is already linked to a Firebase User.',
      ('user-not-found') => 'No user found for that email.',
      ('wrong-password') => 'Wrong password provided for that user.',
      ('weak-password') => 'The password provided is too weak.',
      ('email-already-in-use') => 'The account already exists for that email.',
      ('account-exists-with-different-credential') =>
        'Thrown if there already exists an account with the email address asserted by the credential. Resolve this by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of the returned providers. Once the user is signed in, the original credential can be linked to the user with [linkWithCredential].',
      ('operation-not-allowed') =>
        'Thrown if the type of account corresponding to the credential is not enabled. Enable the account type in the Firebase Console, under the Auth tab.',
      ('user-disabled') =>
        'Thrown if the user corresponding to the given credential has been disabled.',
      ('invalid-email') => 'Thrown if the email address is not valid.',
      ('requires-recent-login') =>
        "Thrown if the user'final s last sign-in final time does not final meet the security threshold. Use [User.reauthenticateWithCredential] to final resolve. This does not apply if the user is anonymous.",
      (_) => 'Failed with error code: $code'
    };
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
    return message;
  }
}

extension FirebaseExceptionExtension on FirebaseException {
  String logException(StackTrace stackTrace, String location) {
    // TODO: Add translation
    final message = switch (code) {
      ('storage/object-not-found') =>
        'No object exists at the desired reference.',
      ('storage/bucket-not-found') =>
        'No bucket is configured for Firebase Storage.',
      ('storage/project-not-found') =>
        'No project is configured for Firebase Storage.',
      ('storage/quota-exceeded') =>
        "Quota on your Cloud Storage bucket has been exceeded. If you're on the no-cost tier, upgrade to a paid plan. If you're on a paid plan, reach out to Firebase support.",
      ('storage/unauthenticated') =>
        'User is unauthenticated, please authenticate and try again.',
      ('storage/unauthorized') =>
        'User is not authorized to perform the desired action, check your security rules to ensure they are correct.',
      ('storage/retry-limit-exceeded') =>
        'The maximum time limit on an operation (upload, download, delete, etc.) has been exceeded. Try uploading again.',
      ('storage/invalid-checksum') =>
        'File on the client does not match the checksum of the file received by the server. Try uploading again.',
      ('storage/canceled') => 'User canceled the operation.',
      ('storage/invalid-event-name') =>
        'Invalid event name provided. Must be one of [running, progress, pause]',
      ('storage/invalid-url') =>
        'Invalid URL provided to refFromURL(). Must be of the form: gs://bucket/object or https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>',
      ('storage/invalid-argument') =>
        'The argument passed to put() must be File, Blob, or UInt8 Array. The argument passed to putString() must be a raw, Base64, or Base64URL string.',
      ('storage/no-default-bucket') =>
        "No bucket has been set in your config's storageBucket property.",
      ('storage/cannot-slice-blob') =>
        "Commonly occurs when the local file has changed (deleted, saved again, etc.). Try uploading again after verifying that the file hasn't changed.",
      ('storage/server-file-wrong-size') =>
        'File on the client does not match the size of the file recieved by the server. Try uploading again.',
      (_) => 'Failed with error code: $code',
    };
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
    return message;
  }
}
