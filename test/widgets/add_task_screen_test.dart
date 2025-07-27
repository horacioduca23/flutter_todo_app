import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/data/repositories/hive_task_repository.dart';
import 'package:flutter_todo_app/src/domain/enum/task_label_enum.dart';
import 'package:flutter_todo_app/src/domain/enum/task_status_enum.dart';
import 'package:flutter_todo_app/src/domain/task.dart';
import 'package:flutter_todo_app/src/presentation/providers.dart';
import 'package:flutter_todo_app/src/presentation/views/tasks/add_task_screen.dart';
import 'package:flutter_todo_app/src/presentation/widgets/adaptive/adaptive_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveTaskRepository extends Mock implements HiveTaskRepository {}

class FakeTask extends Fake implements Task {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  group('AddTaskScreen Widget Tests', () {
    late GoRouter goRouter;
    late MockHiveTaskRepository mockRepository;

    setUp(() {
      mockRepository = MockHiveTaskRepository();
      when(() => mockRepository.addTask(task: any(named: 'task')))
          .thenAnswer((_) async {});

      goRouter = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            name: 'add-task',
            builder: (context, state) => const AddTaskScreen(),
          ),
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) =>
                const Placeholder(key: Key('home-placeholder')),
          ),
        ],
        initialLocation: '/',
      );
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          hiveTaskRepositoryProvider.overrideWithValue(mockRepository),
        ],
        child: MaterialApp.router(routerConfig: goRouter),
      );
    }

    testWidgets(
      'Renderizado inicial: muestra todos los campos y botones principales',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('Agregar tarea'), findsWidgets);
        expect(find.byType(TextField), findsNWidgets(4));
        expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
        expect(find.byIcon(Icons.label_outline), findsOneWidget);
        final addButton = find.descendant(
          of: find.byType(AdaptiveButton),
          matching: find.text('Agregar tarea'),
        );
        expect(addButton, findsOneWidget);
      },
    );

    testWidgets(
      'Flujo de creación de tarea: llena campos, selecciona etiqueta y agrega tarea',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.enterText(
          find.byType(TextField).at(0),
          'Título de prueba',
        );
        await tester.enterText(
          find.byType(TextField).at(1),
          'Prompt de prueba',
        );
        await tester.enterText(
          find.byType(TextField).at(2),
          'Descripción de prueba',
        );
        await tester.enterText(
          find.byType(TextField).at(3),
          'Usuario de prueba',
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.label_outline), warnIfMissed: false);
        await tester.pumpAndSettle();
        final frontendOption = find.text('Frontend');
        if (frontendOption.evaluate().isNotEmpty) {
          await tester.tap(frontendOption.first, warnIfMissed: false);
          await tester.pumpAndSettle();
        }
        final addButton = find.widgetWithText(AdaptiveButton, 'Agregar tarea');
        expect(addButton, findsOneWidget);
        await tester.tap(addButton);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('Botón deshabilitado si los campos están vacíos', (
      tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());
      final addButton = find.widgetWithText(AdaptiveButton, 'Agregar tarea');
      expect(addButton, findsOneWidget);
      final adaptiveButton = tester.widget<AdaptiveButton>(addButton);
      expect(adaptiveButton.onPressed, isNull);
    });
  });
}
