import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/string_constants.dart';
import '../../domain/task.dart';
import '../controllers/home_controllers/task_list_controller.dart';
import 'home_header.dart';

class HomeHeaderSubtitle extends ConsumerWidget {
  const HomeHeaderSubtitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Task>> tasksAsync = ref.watch(
      taskListControllerProvider,
    );

    return tasksAsync.when(
      data: (tasks) {
        final completedTasks = tasks.where((t) => t.isCompleted).length;
        final pendingTasks = tasks.length - completedTasks;
        final areAllTasksCompleted = tasks.isNotEmpty && pendingTasks == 0;

        return HomeHeader(
          title: StringConstants.myTasksTitle,
          subtitle: tasks.isNotEmpty && !areAllTasksCompleted
              ? (StringConstants.tasksCompletedPending
                    .replaceFirst('{completed}', completedTasks.toString())
                    .replaceFirst('{pending}', pendingTasks.toString()))
              : StringConstants.allTasksCompleted,
        );
      },
      loading: () => const HomeHeader(
        title: StringConstants.myTasksTitle,
        subtitle: StringConstants.loadingTasks,
      ),
      error: (e, _) => HomeHeader(
        title: StringConstants.myTasksTitle,
        subtitle: StringConstants.errorLoadingTasks,
      ),
    );
  }
}
