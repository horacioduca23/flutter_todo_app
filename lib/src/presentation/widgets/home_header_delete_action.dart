import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/string_constants.dart';
import '../../core/platform/platform_utils.dart';
import '../../domain/task.dart';
import '../controllers/home_controllers/task_list_controller.dart';
import 'adaptive/adaptive_dialog_alert.dart';

class HomeHeaderDeleteAction extends ConsumerWidget {
  const HomeHeaderDeleteAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Task>> tasksAsync = ref.watch(
      taskListControllerProvider,
    );

    return tasksAsync.when(
      data: (tasks) => IconButton(
        icon: Icon(
          isIOS ? CupertinoIcons.delete : Icons.delete_outline,
          color: Colors.black,
          size: isIOS ? 24.0 : 34.0,
        ),
        onPressed: tasks.isNotEmpty
            ? () async => await showDialog(
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
                            .deleteAllTasks();
                        context.pop();
                      },
                      child: const Text(StringConstants.acceptButton),
                    ),
                  ],
                ),
              )
            : null,
      ),
      loading: () => const IconButton(
        icon: Icon(Icons.delete_outline, color: Colors.grey),
        onPressed: null,
      ),
      error: (_, _) => const IconButton(
        icon: Icon(Icons.delete_outline, color: Colors.grey),
        onPressed: null,
      ),
    );
  }
}
