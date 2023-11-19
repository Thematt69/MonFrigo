import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../error_app.dart';
import '../pages/home_page.dart';
import '../pages/sign_in_page.dart';

enum AppRoute {
  signIn, // Se connecter ou s'inscrire
  home, // Accueil
}

final goRouter = GoRouter(
  initialLocation: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
  debugLogDiagnostics: kDebugMode,
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      path: '/sign-in',
      name: AppRoute.signIn.name,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
