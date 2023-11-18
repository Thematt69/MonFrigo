import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../extension/exception.dart';
import 'bloc_provider.dart';

class FirebaseAuthBloc extends BlocBase {
  @override
  void initState() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          log(
            'User is currently signed out!',
            name: 'FirebaseAuthBloc | initState',
          );
        } else {
          log(
            'User $user is signed in!',
            name: 'FirebaseAuthBloc | initState',
          );
        }
      });
    } catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | initState');
    }
  }

  @override
  void dispose() {}

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> deleteCurrentUser() async {
    try {
      await currentUser?.delete();
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | deleteCurrentUser');
    } catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | deleteCurrentUser');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | sendPasswordResetEmail');
    } catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | sendPasswordResetEmail');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | signOut');
    } catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | signOut');
    }
  }

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | createUserWithEmailAndPassword');
    } catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | createUserWithEmailAndPassword');
    }
    return null;
  }

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | signInWithEmailAndPassword');
    } catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | signInWithEmailAndPassword');
    }
    return null;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/userinfo.profile');

        final userGoogle =
            await FirebaseAuth.instance.signInWithPopup(googleProvider);
        return userGoogle;
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
        return user;
      }
    } on FirebaseException catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | signInWithGoogle');
    } catch (e, s) {
      e.logException(s, 'FirebaseAuthBloc | signInWithGoogle');
    }
    return null;
  }
}
