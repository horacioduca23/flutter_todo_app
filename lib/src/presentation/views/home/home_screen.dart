import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/string_constants.dart';
import '../../../domain/task.dart';
import '../../../routes/app_routes.dart';
import '../../controllers/home_controllers/task_list_controller.dart';
import '../../controllers/home_controllers/task_stats_controller.dart';
import '../../widgets/adaptive/adaptive_app_bar.dart';
import '../../widgets/adaptive/adaptive_button.dart';
import '../../widgets/adaptive/adaptive_dialog_alert.dart';
import '../../widgets/adaptive/adaptive_scaffold.dart';
import '../../widgets/home_header.dart';
import '../../widgets/task_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> taskListController = ref.watch(
      taskListControllerProvider.select((taskList) => taskList),
    );

    final int completedTasks = ref.watch(
      taskStatsControllerProvider.select((task) => task.completed),
    );

    final int pendingTasks = ref.watch(
      taskStatsControllerProvider.select((task) => task.pending),
    );

    final bool areAllTaskCompleted =
        taskListController.length == completedTasks;

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: StringConstants.minimalTodoApp,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.black,
              size: 34.0,
            ),
            onPressed: taskListController.isNotEmpty
                ? () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AdaptiveDialogAlert(
                        title: StringConstants.confirmActionTitle,
                        content: StringConstants.confirmDeleteAllTasks,
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text(StringConstants.cancelButton),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(taskListControllerProvider.notifier)
                                  .cleanTasks();
                              context.pop();
                            },
                            child: const Text(StringConstants.acceptButton),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              HomeHeader(
                title: StringConstants.myTasksTitle,
                subtitle: taskListController.isNotEmpty && !areAllTaskCompleted
                    ? (StringConstants.tasksCompletedPending
                          .replaceFirst(
                            '{completed}',
                            completedTasks.toString(),
                          )
                          .replaceFirst('{pending}', pendingTasks.toString()))
                    : StringConstants.allTasksCompleted,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: const Divider(color: Colors.grey, thickness: 1.5),
              ),
              const SizedBox(height: 20),
              if (taskListController.isEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(StringConstants.contentChargingGif),
                        Image.asset(
                          StringConstants.allDoneGif,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: taskListController.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TaskCard(
                        task: taskListController[index],
                        onDismissed: () => ref
                            .read(taskListControllerProvider.notifier)
                            .removeTask(taskId: taskListController[index].id),
                        onTap: () => context.goNamed(
                          AppRoutes.editTask.name,
                          extra: taskListController[index],
                        ),
                        onToggleCompleted: () => ref
                            .read(taskListControllerProvider.notifier)
                            .toggleTaskCompletion(
                              taskId: taskListController[index].id,
                            ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: AdaptiveButton(
        color: const Color(0xFF4A6CF7),
        isFilled: true,
        onPressed: () => context.goNamed(AppRoutes.addTask.name),
        child: const Icon(Icons.add, color: Colors.white, size: 28.0),
      ),
    );
  }
}
