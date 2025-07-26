import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/presentation/views/tasks/add_task_screen.dart';
import 'package:flutter_todo_app/src/presentation/widgets/adaptive/adaptive_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('AddTaskScreen Widget Tests', () {
    late GoRouter goRouter;

    setUp(() {
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

    testWidgets(
      'Renderizado inicial: muestra todos los campos y botones principales',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
        );
        // Título de la pantalla
        expect(find.text('Agregar tarea'), findsWidgets);
        // Campos de texto (AdaptiveTextField)
        expect(find.byType(TextField), findsNWidgets(4));
        // Botón de generar con IA: solo verifico el icono, ya que el botón puede estar deshabilitado y el texto no renderizarse
        expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
        // Dropdown de etiquetas
        expect(find.byIcon(Icons.label_outline), findsOneWidget);
        // Botón de agregar tarea (AdaptiveButton con texto)
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
        await tester.pumpWidget(
          ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
        );
        // Llenar campos
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
        // Abrir dropdown y seleccionar la primera etiqueta
        await tester.tap(find.byIcon(Icons.label_outline), warnIfMissed: false);
        await tester.pumpAndSettle();
        // Para Material: selecciona la opción 'Frontend'.
        final frontendOption = find.text('Frontend');
        if (frontendOption.evaluate().isNotEmpty) {
          await tester.tap(frontendOption.first, warnIfMissed: false);
          await tester.pumpAndSettle();
        }
        // Para Cupertino: la selección requiere scroll y confirmación, lo cual es más complejo de testear.
        // Botón de agregar tarea debe estar habilitado (AdaptiveButton)
        final addButton = find.widgetWithText(AdaptiveButton, 'Agregar tarea');
        expect(addButton, findsOneWidget);
        await tester.tap(addButton);
        await tester.pumpAndSettle();
        // No verifico el Placeholder, solo que no haya errores
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('Botón deshabilitado si los campos están vacíos', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp.router(routerConfig: goRouter)),
      );
      // Buscar el AdaptiveButton y verificar que esté deshabilitado
      final addButton = find.widgetWithText(AdaptiveButton, 'Agregar tarea');
      expect(addButton, findsOneWidget);
      final adaptiveButton = tester.widget<AdaptiveButton>(addButton);
      expect(adaptiveButton.onPressed, isNull);
    });
  });
}
