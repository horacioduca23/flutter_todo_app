import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/domain/enum/task_label_enum.dart';
import 'package:flutter_todo_app/src/domain/enum/task_status_enum.dart';
import 'package:flutter_todo_app/src/domain/task.dart';
import 'package:flutter_todo_app/src/presentation/controllers/home_controllers/task_list_controller.dart';
import 'package:flutter_todo_app/src/presentation/views/home/home_screen.dart';
import 'package:flutter_todo_app/src/presentation/widgets/adaptive/adaptive_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('HomeScreen', () {
    late List<Task> mockTasks;
    late GoRouter goRouter;

    setUp(() {
      mockTasks = [
        Task(
          id: '1',
          title: 'Tarea 1',
          description: 'Desc 1',
          isCompleted: false,
          label: TaskLabelEnum.frontend,
          status: TaskStatusEnum.pending,
          userAssigned: 'user1',
        ),
        Task(
          id: '2',
          title: 'Tarea 2',
          description: 'Desc 2',
          isCompleted: true,
          label: TaskLabelEnum.backend,
          status: TaskStatusEnum.completed,
          userAssigned: 'user2',
        ),
      ];
      goRouter = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/add-task',
            name: 'add-task',
            builder: (context, state) =>
                const Placeholder(key: Key('add-task-placeholder')),
          ),
          GoRoute(
            path: '/edit-task',
            name: 'edit-task',
            builder: (context, state) =>
                const Placeholder(key: Key('edit-task-placeholder')),
          ),
        ],
        initialLocation: '/',
      );
    });

    testWidgets('renderiza correctamente con lista vacía', (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
      );
      expect(find.text('Mis Tareas'), findsNWidgets(2));
      expect(find.byType(Image), findsNWidgets(2));
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(AdaptiveButton), findsOneWidget);
    });

    testWidgets('renderiza lista de tareas y widgets internos', (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
      );
      final container = ProviderScope.containerOf(
        tester.element(find.byType(HomeScreen)),
      );
      final notifier = container.read(taskListControllerProvider.notifier);
      for (final task in mockTasks) {
        notifier.addTask(task: task);
      }
      await tester.pumpAndSettle();
      expect(find.text('Tarea 1'), findsOneWidget);
      expect(find.text('Tarea 2'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(AdaptiveButton), findsOneWidget);
      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(Dismissible), findsWidgets);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('puede limpiar tareas con el botón de basura', (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
      );
      final container = ProviderScope.containerOf(
        tester.element(find.byType(HomeScreen)),
      );
      final notifier = container.read(taskListControllerProvider.notifier);
      for (final task in mockTasks) {
        notifier.addTask(task: task);
      }
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();
      expect(notifier.state, isEmpty);
    });

    testWidgets('puede agregar tarea con el FAB', (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
      );
      await tester.tap(find.byType(AdaptiveButton));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('add-task-placeholder')), findsOneWidget);
    });

    testWidgets('puede marcar tarea como completada', (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
      );
      final container = ProviderScope.containerOf(
        tester.element(find.byType(HomeScreen)),
      );
      final notifier = container.read(taskListControllerProvider.notifier);
      for (final task in mockTasks) {
        notifier.addTask(task: task);
      }
      await tester.pumpAndSettle();
      // Busca todos los GestureDetector del checkbox por constraints
      final checkBoxes = find.byWidgetPredicate((widget) {
        if (widget is GestureDetector) {
          final child = widget.child;
          if (child is Container &&
              child.constraints != null &&
              child.constraints!.maxWidth == 24 &&
              child.constraints!.maxHeight == 24) {
            return true;
          }
        }
        return false;
      });
      await tester.tap(checkBoxes.at(0));
      await tester.pumpAndSettle();
      expect(notifier.state.first.isCompleted, isTrue);
    });

    testWidgets('puede eliminar tarea con swipe', (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
      );
      final container = ProviderScope.containerOf(
        tester.element(find.byType(HomeScreen)),
      );
      final notifier = container.read(taskListControllerProvider.notifier);
      for (final task in mockTasks) {
        notifier.addTask(task: task);
      }
      await tester.pumpAndSettle();
      final dismissible = find.byType(Dismissible).first;
      await tester.drag(dismissible, const Offset(-500, 0));
      await tester.pumpAndSettle();
      expect(notifier.state.length, 1);
    });
  });
}
