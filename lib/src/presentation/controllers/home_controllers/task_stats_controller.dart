import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/task.dart';
import '../../../domain/task_stats.dart';
import 'task_list_controller.dart';

part 'task_stats_controller.g.dart';

@riverpod
class TaskStatsController extends _$TaskStatsController {
  @override
  TaskStats build() {
    final List<Task> taskList = ref.watch(taskListControllerProvider);

    final int completed = taskList.where((task) => task.isCompleted).length;
    final int pending = taskList.length - completed;

    return TaskStats(completed: completed, pending: pending);
  }
}
