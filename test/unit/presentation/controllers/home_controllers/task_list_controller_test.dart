import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/data/repositories/hive_task_repository.dart';
import 'package:flutter_todo_app/src/domain/enum/task_label_enum.dart';
import 'package:flutter_todo_app/src/domain/enum/task_status_enum.dart';
import 'package:flutter_todo_app/src/domain/task.dart';
import 'package:flutter_todo_app/src/presentation/controllers/home_controllers/task_list_controller.dart';
import 'package:flutter_todo_app/src/presentation/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class FakeTask extends Fake implements Task {}

class MockHiveTaskRepository extends Mock implements HiveTaskRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  late MockHiveTaskRepository mockRepository;
  late ProviderContainer container;
  late Task sampleTask;
  late Task anotherTask;

  setUp(() {
    mockRepository = MockHiveTaskRepository();
    sampleTask = Task.create(
      id: '1',
      title: 'Test Task',
      description: 'Description',
      isCompleted: false,
      label: TaskLabelEnum.work,
      status: TaskStatusEnum.pending,
      userAssigned: 'user1',
    );
    anotherTask = Task.create(
      id: '2',
      title: 'Another Task',
      description: 'Another Description',
      isCompleted: false,
      label: TaskLabelEnum.personal,
      status: TaskStatusEnum.pending,
      userAssigned: 'user2',
    );

    container = ProviderContainer(
      overrides: [hiveTaskRepositoryProvider.overrideWithValue(mockRepository)],
    );

    when(() => mockRepository.getTasks()).thenAnswer((_) async => []);
  });

  tearDown(() {
    container.dispose();
  });

  test('El estado inicial debe ser AsyncData con una lista vacía', () async {
    await container.read(taskListControllerProvider.future);
    final state = container.read(taskListControllerProvider);

    expect(state, isA<AsyncData<List<Task>>>());
    expect(state.value, isEmpty);
  });

  test('addTask debe llamar al repositorio y refrescar el estado', () async {
    when(
      () => mockRepository.addTask(task: sampleTask),
    ).thenAnswer((_) async {});
    when(() => mockRepository.getTasks()).thenAnswer((_) async => [sampleTask]);

    await container
        .read(taskListControllerProvider.notifier)
        .addTask(task: sampleTask);

    verify(() => mockRepository.addTask(task: sampleTask)).called(1);
  });

  test(
    'deleteTask debe llamar al repositorio y actualizar el estado',
    () async {
      when(
        () => mockRepository.getTasks(),
      ).thenAnswer((_) async => [sampleTask, anotherTask]);
      when(
        () => mockRepository.deleteTask(id: sampleTask.id),
      ).thenAnswer((_) async {});
      await container.read(taskListControllerProvider.future);

      await container
          .read(taskListControllerProvider.notifier)
          .deleteTask(taskId: sampleTask.id);

      verify(() => mockRepository.deleteTask(id: sampleTask.id)).called(1);
    },
  );

  test(
    'updateTask debe llamar al repositorio y actualizar el estado',
    () async {
      final updatedTask = sampleTask.copyWith(title: 'Updated');
      when(
        () => mockRepository.getTasks(),
      ).thenAnswer((_) async => [sampleTask]);
      when(
        () => mockRepository.updateTask(task: updatedTask),
      ).thenAnswer((_) async {});
      await container.read(taskListControllerProvider.future);

      await container
          .read(taskListControllerProvider.notifier)
          .updateTask(task: updatedTask);

      verify(() => mockRepository.updateTask(task: updatedTask)).called(1);
    },
  );

  test(
    'toggleTaskCompletion debe actualizar la tarea con los valores correctos',
    () async {
      when(
        () => mockRepository.getTasks(),
      ).thenAnswer((_) async => [sampleTask]);

      when(
        () => mockRepository.updateTask(task: any(named: 'task')),
      ).thenAnswer((_) async {});

      await container.read(taskListControllerProvider.future);

      await container
          .read(taskListControllerProvider.notifier)
          .toggleTaskCompletion(taskId: sampleTask.id);

      final captured = verify(
        () => mockRepository.updateTask(task: captureAny(named: 'task')),
      ).captured;
      final capturedTask = captured.first as Task;

      expect(capturedTask.id, sampleTask.id);
      expect(capturedTask.isCompleted, isTrue);
      expect(capturedTask.statusEnum, TaskStatusEnum.completed);
    },
  );
}
