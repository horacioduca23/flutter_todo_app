import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/string_constants.dart';
import '../../../domain/enum/task_status_enum.dart';
import '../../../domain/task.dart';
import '../../providers.dart';

part 'task_list_controller.g.dart';

@Riverpod(keepAlive: true)
class TaskListController extends _$TaskListController {
  @override
  Future<List<Task>> build() async {
    return _getTask();
  }

  Future<List<Task>> _getTask() {
    try {
      return ref.read(hiveTaskRepositoryProvider).getTasks();
    } catch (e) {
      throw Exception(StringConstants.errorPrefix + e.toString());
    }
  }

  Future<void> addTask({required Task task}) async {
    try {
      await ref.read(hiveTaskRepositoryProvider).addTask(task: task);
      ref.invalidateSelf();
    } catch (e) {
      throw Exception(StringConstants.errorPrefix + e.toString());
    }
  }

  Future<void> updateTask({required Task task}) async {
    try {
      await ref.read(hiveTaskRepositoryProvider).updateTask(task: task);
      ref.invalidateSelf();
    } catch (e) {
      throw Exception(StringConstants.errorPrefix + e.toString());
    }
  }

  Future<void> deleteTask({required String taskId}) async {
    final previousState = state;
    state = AsyncValue.data(
      state.value!.where((task) => task.id != taskId).toList(),
    );
    try {
      await ref.read(hiveTaskRepositoryProvider).deleteTask(id: taskId);
    } catch (e) {
      state = previousState;
      throw Exception(StringConstants.errorPrefix + e.toString());
    }
  }

  Future<void> deleteAllTasks() async {
    final previousState = state;
    state = const AsyncValue.data([]);
    try {
      await ref.read(hiveTaskRepositoryProvider).deleteAllTasks();
    } catch (e) {
      state = previousState;
      throw Exception(StringConstants.errorPrefix + e.toString());
    }
  }

  Future<void> toggleTaskCompletion({required String taskId}) async {
    if (!state.hasValue || state.value == null) {
      return;
    }

    final previousState = state;

    state = AsyncValue.data([
      for (final task in state.value!)
        if (task.id == taskId)
          task.copyWith(
            isCompleted: !task.isCompleted,
            status: task.isCompleted
                ? TaskStatusEnum.pending
                : TaskStatusEnum.completed,
          )
        else
          task,
    ]);

    try {
      final taskToUpdate = state.value!.firstWhere((t) => t.id == taskId);
      await ref.read(hiveTaskRepositoryProvider).updateTask(task: taskToUpdate);
    } catch (e) {
      state = previousState;
      throw Exception(StringConstants.errorPrefix + e.toString());
    }
  }
}
