import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/string_constants.dart';
import '../../domain/task.dart';
import '../../routes/app_routes.dart';
import '../controllers/home_controllers/task_list_controller.dart';
import 'adaptive/adaptive_progress_indicator.dart';
import 'task_card.dart';

class HomeBodyContent extends ConsumerWidget {
  const HomeBodyContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Task>> tasksAsync = ref.watch(
      taskListControllerProvider,
    );
    return Expanded(
      child: tasksAsync.when(
        data: (tasks) => tasks.isEmpty
            ? Column(
                children: [
                  Image.asset(StringConstants.contentChargingGif),
                  Image.asset(StringConstants.allDoneGif, color: Colors.black),
                ],
              )
            : ListView.separated(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TaskCard(
                      task: task,
                      onDismissed: () => ref
                          .read(taskListControllerProvider.notifier)
                          .deleteTask(taskId: task.id),
                      onTap: () =>
                          context.goNamed(AppRoutes.editTask.name, extra: task),
                      onToggleCompleted: () => ref
                          .read(taskListControllerProvider.notifier)
                          .toggleTaskCompletion(taskId: task.id),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
              ),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const AdaptiveProgressIndicator(),
      ),
    );
  }
}
