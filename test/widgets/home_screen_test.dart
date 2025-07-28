import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/data/repositories/hive_task_repository.dart';
import 'package:flutter_todo_app/src/domain/enum/task_label_enum.dart';
import 'package:flutter_todo_app/src/domain/enum/task_status_enum.dart';
import 'package:flutter_todo_app/src/domain/task.dart';
import 'package:flutter_todo_app/src/presentation/providers.dart';
import 'package:flutter_todo_app/src/presentation/views/home/home_screen.dart';
import 'package:flutter_todo_app/src/presentation/widgets/task_card.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveTaskRepository extends Mock implements HiveTaskRepository {}

class FakeTask extends Fake implements Task {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  late MockHiveTaskRepository mockRepository;
  late List<Task> mockTasks;
  late GoRouter goRouter;

  setUp(() {
    mockRepository = MockHiveTaskRepository();
    mockTasks = [
      Task.create(
        id: '1',
        title: 'Tarea 1',
        description: 'Desc 1',
        isCompleted: false,
        label: TaskLabelEnum.personal,
        status: TaskStatusEnum.pending,
        userAssigned: 'user1',
      ),
      Task.create(
        id: '2',
        title: 'Tarea 2',
        description: 'Desc 2',
        isCompleted: true,
        label: TaskLabelEnum.work,
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
      ],
      initialLocation: '/',
    );

    when(() => mockRepository.getTasks()).thenAnswer((_) async => []);
    when(() => mockRepository.deleteAllTasks()).thenAnswer((_) async {});
    when(
      () => mockRepository.deleteTask(id: any(named: 'id')),
    ).thenAnswer((_) async {});
  });

  tearDown(() {
    reset(mockRepository);
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [hiveTaskRepositoryProvider.overrideWithValue(mockRepository)],
      child: MaterialApp.router(routerConfig: goRouter),
    );
  }

  testWidgets('Muestra indicador de carga y luego pantalla vacía', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Mis Tareas'), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets('Muestra la lista de tareas correctamente', (tester) async {
    when(() => mockRepository.getTasks()).thenAnswer((_) async => mockTasks);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(TaskCard), findsNWidgets(2));
    expect(find.text('Tarea 1'), findsOneWidget);
    expect(find.text('Tarea 2'), findsOneWidget);
  });

  testWidgets('Navega a la pantalla de añadir tarea al pulsar el FAB', (
    tester,
  ) async {
    // Configurar un tamaño de pantalla más grande para evitar overflow
    await tester.binding.setSurfaceSize(const Size(800, 1200));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verificar que el FAB está presente antes de hacer tap
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('add-task-placeholder')), findsOneWidget);

    // Limpieza final para evitar el error de widget deactivated
    await tester.pumpAndSettle();

    // Restaurar el tamaño de pantalla original
    await tester.binding.setSurfaceSize(null);
  });
}
