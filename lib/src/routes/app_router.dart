import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/views/home/home_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home.path,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}
