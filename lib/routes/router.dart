import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/sample_item_details_view.dart';
import '../pages/sample_item_list_view.dart';

enum AppRoute { sampleItemListView, sampleItemDetailsView }

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: kDebugMode,
  redirect: (BuildContext context, GoRouterState state) {
    // if (AuthState.of(context).isSignedIn) {
    //   return '/signin';
    // } else {
    //   return null;
    // }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.sampleItemListView.name,
      builder: (context, state) => const SampleItemListView(),
      routes: [
        GoRoute(
          path: 'details',
          name: AppRoute.sampleItemDetailsView.name,
          builder: (context, state) => const SampleItemDetailsView(),
        ),
      ],
    ),
  ],
);
