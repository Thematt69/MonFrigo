import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../extension/exception.dart';
import 'bloc_provider.dart';

class FirebaseAuthBloc extends BlocBase {
  @override
  void initState() {}

  @override
  void dispose() {}

  Future<Either<void, String>> deleteCurrentUser() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      return left(null);
    } on FirebaseAuthException catch (e, s) {
      final exception =
          e.logException(s, 'FirebaseAuthBloc | deleteCurrentUser');
      return right(exception);
    } catch (e, s) {
      final exception =
          e.logException(s, 'FirebaseAuthBloc | deleteCurrentUser');
      return right(exception);
    }
  }

  Future<Either<void, String>> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return left(null);
    } on FirebaseAuthException catch (e, s) {
      final exception =
          e.logException(s, 'FirebaseAuthBloc | sendPasswordResetEmail');
      return right(exception);
    } catch (e, s) {
      final exception =
          e.logException(s, 'FirebaseAuthBloc | sendPasswordResetEmail');
      return right(exception);
    }
  }

  Future<Either<void, String>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return left(null);
    } on FirebaseAuthException catch (e, s) {
      final exception = e.logException(s, 'FirebaseAuthBloc | signOut');
      return right(exception);
    } catch (e, s) {
      final exception = e.logException(s, 'FirebaseAuthBloc | signOut');
      return right(exception);
    }
  }

  Future<Either<UserCredential?, String>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return left(user);
    } on FirebaseAuthException catch (e, s) {
      final exception = e.logException(
        s,
        'FirebaseAuthBloc | createUserWithEmailAndPassword',
      );
      return right(exception);
    } catch (e, s) {
      final exception = e.logException(
        s,
        'FirebaseAuthBloc | createUserWithEmailAndPassword',
      );
      return right(exception);
    }
  }

  Future<Either<UserCredential?, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return left(user);
    } on FirebaseAuthException catch (e, s) {
      final exception =
          e.logException(s, 'FirebaseAuthBloc | signInWithEmailAndPassword');
      return right(exception);
    } catch (e, s) {
      final exception =
          e.logException(s, 'FirebaseAuthBloc | signInWithEmailAndPassword');
      return right(exception);
    }
  }

  Future<Either<UserCredential?, String>> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/userinfo.profile');

        final user =
            await FirebaseAuth.instance.signInWithPopup(googleProvider);
        return left(user);
      } else if (Platform.isWindows) {
        throw UnimplementedError('signInWithGoogle not implemented on Windows');
      } else {
        final googleUser = await GoogleSignIn().signIn();

        final googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        final user =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return left(user);
      }
    } on FirebaseAuthException catch (e, s) {
      final exception =
          e.logException(s, 'FirebaseAuthBloc | signInWithGoogle');
      return right(exception);
    } catch (e, s) {
      final exception =
          e.logException(s, 'FirebaseAuthBloc | signInWithGoogle');
      return right(exception);
    }
  }
}
