import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/string_constants.dart';
import '../../../core/platform/platform_utils.dart';
import '../../../domain/enum/task_label_enum.dart';
import '../../../domain/task.dart';
import '../../controllers/home_controllers/task_list_controller.dart';
import '../../controllers/task_controllers/all_edit_fields_are_valid_controller.dart';
import '../../controllers/task_controllers/description_controller.dart';
import '../../controllers/task_controllers/task_label_controller.dart';
import '../../controllers/task_controllers/title_controller.dart';
import '../../controllers/task_controllers/user_assigned_controller.dart';
import '../../widgets/adaptive/adaptive_app_bar.dart';
import '../../widgets/adaptive/adaptive_scaffold.dart';
import '../../widgets/adaptive/adaptive_snack_bar.dart';
import '../../widgets/task_bottom_bar.dart';
import '../../widgets/task_form.dart';
import '../../widgets/task_form_header.dart';

class EditTaskScreen extends ConsumerWidget {
  const EditTaskScreen({super.key, required this.task});

  final Task task;

  void _invalidateProviders(WidgetRef ref) {
    ref.invalidate(titleControllerProvider);
    ref.invalidate(descriptionControllerProvider);
    ref.invalidate(userAssignedControllerProvider);
    ref.invalidate(taskLabelControllerProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TaskLabelEnum? currentLabel = ref.watch(taskLabelControllerProvider);
    final bool allFieldsAreValid = ref.watch(
      allEditFieldsAreValidControllerProvider(
        initialTitle: task.title,
        initialDescription: task.description,
        initialUserAssigned: task.userAssigned,
        initialLabel: task.labelEnum,
      ),
    );

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: StringConstants.updateTaskTitle,
        leading: IconButton(
          icon: Icon(
            isIOS ? CupertinoIcons.chevron_left : Icons.arrow_back,
            color: Colors.black,
            size: isIOS ? 24.0 : 34.0,
          ),
          onPressed: () {
            _invalidateProviders(ref);
            context.pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const TaskFormHeader(title: StringConstants.updateTaskTitle),
                const SizedBox(height: 40),
                TaskForm(initialTask: task, isEditMode: true),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: TaskBottomBar(
        title: StringConstants.addTaskButton,
        onPressed: allFieldsAreValid
            ? () {
                ref
                    .read(taskListControllerProvider.notifier)
                    .updateTask(
                      task: task.copyWith(
                        description:
                            ref.read(descriptionControllerProvider) ?? '',
                        label: currentLabel,
                        title: ref.read(titleControllerProvider),
                        userAssigned: ref.read(userAssignedControllerProvider),
                      ),
                    );

                AdaptiveSnackBar.showAndNavigate(
                  context,
                  message: StringConstants.taskUpdatedSuccess,
                  backgroundColor: Colors.green,
                  onNavigate: () => context.pop(),
                );
              }
            : null,
      ),
    );
  }
}
