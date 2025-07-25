import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../domain/task.dart';
import '../presentation/views/home/home_screen.dart';
import '../presentation/views/tasks/add_task_screen.dart';
import '../presentation/views/tasks/edit_task_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.addTask.path,
            name: AppRoutes.addTask.name,
            builder: (BuildContext context, GoRouterState state) {
              return const AddTaskScreen();
            },
          ),
          GoRoute(
            path: AppRoutes.editTask.path,
            name: AppRoutes.editTask.name,
            builder: (BuildContext context, GoRouterState state) {
              final task = state.extra as Task;

              return EditTaskScreen(task: task);
            },
          ),
        ],
      ),
    ],
  );
}
