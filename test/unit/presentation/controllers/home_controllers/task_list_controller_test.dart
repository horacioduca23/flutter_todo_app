import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/domain/enum/task_label_enum.dart';
import 'package:flutter_todo_app/src/domain/enum/task_status_enum.dart';
import 'package:flutter_todo_app/src/domain/task.dart';
import 'package:flutter_todo_app/src/presentation/controllers/home_controllers/task_list_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('TaskListController', () {
    late ProviderContainer container;
    late Task sampleTask;
    late Task anotherTask;

    setUp(() {
      container = ProviderContainer();
      sampleTask = Task(
        id: '1',
        title: 'Test Task',
        description: 'Description',
        isCompleted: false,
        label: TaskLabelEnum.frontend,
        status: TaskStatusEnum.pending,
        userAssigned: 'user1',
      );
      anotherTask = Task(
        id: '2',
        title: 'Another Task',
        description: 'Another Description',
        isCompleted: false,
        label: TaskLabelEnum.backend,
        status: TaskStatusEnum.pending,
        userAssigned: 'user2',
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('estado inicial debe ser una lista vacía', () {
      final state = container.read(taskListControllerProvider);
      expect(state, isEmpty);
    });

    test('addTask agrega una tarea correctamente', () {
      final notifier = container.read(taskListControllerProvider.notifier);
      notifier.addTask(task: sampleTask);
      final state = container.read(taskListControllerProvider);
      expect(state.length, 1);
      expect(state.first, sampleTask);
    });

    test('removeTask elimina la tarea por id', () {
      final notifier = container.read(taskListControllerProvider.notifier);
      notifier.addTask(task: sampleTask);
      notifier.addTask(task: anotherTask);
      notifier.removeTask(taskId: sampleTask.id);
      final state = container.read(taskListControllerProvider);
      expect(state.length, 1);
      expect(state.first, anotherTask);
    });

    test('removeTask no elimina nada si el id no existe', () {
      final notifier = container.read(taskListControllerProvider.notifier);
      notifier.addTask(task: sampleTask);
      notifier.removeTask(taskId: 'no-existe');
      final state = container.read(taskListControllerProvider);
      expect(state.length, 1);
      expect(state.first, sampleTask);
    });

    test('updateTask actualiza la tarea correctamente', () {
      final notifier = container.read(taskListControllerProvider.notifier);
      notifier.addTask(task: sampleTask);
      final updatedTask = sampleTask.copyWith(title: 'Updated');
      notifier.updateTask(updatedTask: updatedTask);
      final state = container.read(taskListControllerProvider);
      expect(state.length, 1);
      expect(state.first.title, 'Updated');
    });

    test('updateTask no cambia nada si el id no existe', () {
      final notifier = container.read(taskListControllerProvider.notifier);
      notifier.addTask(task: sampleTask);
      final updatedTask = anotherTask.copyWith(title: 'Updated');
      notifier.updateTask(updatedTask: updatedTask);
      final state = container.read(taskListControllerProvider);
      expect(state.length, 1);
      expect(state.first, sampleTask);
    });

    test('cleanTasks limpia todas las tareas', () {
      final notifier = container.read(taskListControllerProvider.notifier);
      notifier.addTask(task: sampleTask);
      notifier.addTask(task: anotherTask);
      notifier.cleanTasks();
      final state = container.read(taskListControllerProvider);
      expect(state, isEmpty);
    });

    test('toggleTaskCompletion cambia el estado de completado y status', () {
      final notifier = container.read(taskListControllerProvider.notifier);
      notifier.addTask(task: sampleTask);
      notifier.toggleTaskCompletion(taskId: sampleTask.id);
      final state = container.read(taskListControllerProvider);
      expect(state.first.isCompleted, isTrue);
      expect(state.first.status, TaskStatusEnum.completed);
      // Volver a llamar debe volver a pending
      notifier.toggleTaskCompletion(taskId: sampleTask.id);
      final state2 = container.read(taskListControllerProvider);
      expect(state2.first.isCompleted, isFalse);
      expect(state2.first.status, TaskStatusEnum.pending);
    });

    test('toggleTaskCompletion no cambia nada si el id no existe', () {
      final notifier = container.read(taskListControllerProvider.notifier);
      notifier.addTask(task: sampleTask);
      notifier.toggleTaskCompletion(taskId: 'no-existe');
      final state = container.read(taskListControllerProvider);
      expect(state.first, sampleTask);
    });
  });
}
