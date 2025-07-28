import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/string_constants.dart';
import '../../../core/platform/platform_utils.dart';
import '../../../domain/enum/task_label_enum.dart';
import '../../../domain/enum/task_status_enum.dart';
import '../../../domain/task.dart';
import '../../controllers/home_controllers/task_list_controller.dart';
import '../../controllers/task_controllers/all_fields_are_valid_controller.dart';
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

class AddTaskScreen extends ConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TaskLabelEnum? label = ref.watch(taskLabelControllerProvider);
    final bool areAllFieldsFilled = ref.watch(
      allFieldsAreValidControllerProvider,
    );
    final bool isValid = areAllFieldsFilled && label != null;

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: StringConstants.addTaskTitle,
        leading: IconButton(
          icon: Icon(
            isIOS ? CupertinoIcons.chevron_left : Icons.arrow_back,
            color: Colors.black,
            size: isIOS ? 24.0 : 34.0,
          ),
          onPressed: () => context.pop(),
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
                const TaskFormHeader(title: StringConstants.addTaskTitle),
                const SizedBox(height: 40),
                const TaskForm(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: TaskBottomBar(
        title: StringConstants.addTaskButton,
        onPressed: isValid
            ? () {
                ref
                    .read(taskListControllerProvider.notifier)
                    .addTask(
                      task: Task(
                        description:
                            ref.read(descriptionControllerProvider) ?? '',
                        id: DateTime.now().toString(),
                        isCompleted: false,
                        label: label.name,
                        status: TaskStatusEnum.pending.name,
                        title: ref.read(titleControllerProvider),
                        userAssigned: ref.read(userAssignedControllerProvider),
                      ),
                    );

                AdaptiveSnackBar.showAndNavigate(
                  context,
                  message: StringConstants.taskAddedSuccess,
                  backgroundColor: Colors.green,
                  onNavigate: () => context.pop(),
                );
              }
            : null,
      ),
    );
  }
}
