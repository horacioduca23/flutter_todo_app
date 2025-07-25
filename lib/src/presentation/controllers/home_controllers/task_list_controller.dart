import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/enum/task_status_enum.dart';
import '../../../domain/task.dart';

part 'task_list_controller.g.dart';

@riverpod
class TaskListController extends _$TaskListController {
  @override
  List<Task> build() {
    return <Task>[];
  }

  void addTask({required Task task}) {
    state = [...state, task];
  }

  void removeTask({required String taskId}) {
    state = state.where((task) => task.id != taskId).toList();
  }

  void updateTask({required Task updatedTask}) {
    state = state.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
  }

  void cleanTasks() {
    state = [];
  }

  void toggleTaskCompletion({required String taskId}) {
    state = state.map((task) {
      return task.id == taskId
          ? task.copyWith(
              isCompleted: !task.isCompleted,
              status: task.isCompleted
                  ? TaskStatusEnum.pending
                  : TaskStatusEnum.completed,
            )
          : task;
    }).toList();
  }
}
