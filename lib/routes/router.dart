import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../error_app.dart';
import '../pages/alerts/alerts_page.dart';
import '../pages/fridge/fridge_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/shopping_list_page.dart';
import '../pages/sign_in_page.dart';

enum AppRoute {
  signIn, // Se connecter ou s'inscrire
  fridge, // Mon frigo
  shoppingList, // Ma liste de courses
  alerts, // Mes alertes
  profile, // Mon profil
}

CustomTransitionPage<T> _noTransitionBuilder<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (_, __, ___, child) => child,
  );
}

// CustomTransitionPage<T> _leftToRightBuilder<T>({
//   required GoRouterState state,
//   required Widget child,
// }) {
//   const begin = Offset(-1, 0);
//   const end = Offset.zero;
//   const curve = Curves.easeOut;

//   final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//   return CustomTransitionPage<T>(
//     key: state.pageKey,
//     child: child,
//     transitionsBuilder: (_, Animation<double> animation, __, child) =>
//         SlideTransition(
//       position: animation.drive(tween),
//       child: child,
//     ),
//   );
// }

// CustomTransitionPage<T> _rightToLeftBuilder<T>({
//   required GoRouterState state,
//   required Widget child,
// }) {
//   const begin = Offset(1, 0);
//   const end = Offset.zero;
//   const curve = Curves.easeOut;

//   final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//   return CustomTransitionPage<T>(
//     key: state.pageKey,
//     child: child,
//     transitionsBuilder: (_, Animation<double> animation, __, child) =>
//         SlideTransition(
//       position: animation.drive(tween),
//       child: child,
//     ),
//   );
// }

final navigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  restorationScopeId: 'com.thematt69.mon_frigo',
  initialLocation: '/fridge',
  debugLogDiagnostics: kDebugMode,
  navigatorKey: navigatorKey,
  errorBuilder: (context, state) => const ErrorPage(),
  redirect: (context, state) {
    if (FirebaseAuth.instance.currentUser == null) {
      return '/sign-in';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/sign-in',
      name: AppRoute.signIn.name,
      pageBuilder: (_, state) => _noTransitionBuilder(
        state: state,
        child: const SignInPage(),
      ),
    ),
    GoRoute(
      path: '/fridge',
      name: AppRoute.fridge.name,
      pageBuilder: (context, state) => _noTransitionBuilder(
        state: state,
        child: const FridgePage(),
      ),
    ),
    GoRoute(
      path: '/shopping-list',
      name: AppRoute.shoppingList.name,
      pageBuilder: (context, state) => _noTransitionBuilder(
        state: state,
        child: const ShoppingListPage(),
      ),
    ),
    GoRoute(
      path: '/alerts',
      name: AppRoute.alerts.name,
      pageBuilder: (context, state) => _noTransitionBuilder(
        state: state,
        child: const AlertsPage(),
      ),
    ),
    GoRoute(
      path: '/profile',
      name: AppRoute.profile.name,
      pageBuilder: (context, state) => _noTransitionBuilder(
        state: state,
        child: const ProfilePage(),
      ),
    ),
  ],
);
