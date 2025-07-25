import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/string_constants.dart';
import '../../../domain/enum/task_label_enum.dart';
import '../../../domain/task.dart';
import '../../controllers/home_controllers/task_list_controller.dart';
import '../../controllers/task_controllers/all_edit_fields_are_valid_controller.dart';
import '../../controllers/task_controllers/description_controller.dart';
import '../../controllers/task_controllers/task_label_controller.dart';
import '../../controllers/task_controllers/title_controller.dart';
import '../../controllers/task_controllers/user_assigned_controller.dart';
import '../../widgets/adaptive/adaptive_app_bar.dart';
import '../../widgets/adaptive/adaptive_button.dart';
import '../../widgets/adaptive/adaptive_scaffold.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/field_section_title.dart';
import '../../widgets/task_form_header.dart';
import 'add_task_screen.dart';

class EditTaskScreen extends HookConsumerWidget {
  const EditTaskScreen({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = useTextEditingController(
      text: task.title,
    );
    final TextEditingController promptController = useTextEditingController();
    final TextEditingController descriptionController =
        useTextEditingController(text: task.description);
    final TextEditingController userAssignedController =
        useTextEditingController(text: task.userAssigned);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(titleControllerProvider.notifier)
            .updateTitle(title: task.title);
        ref
            .read(descriptionControllerProvider.notifier)
            .updateDescription(description: task.description);
        ref
            .read(userAssignedControllerProvider.notifier)
            .updateUserAssigned(user: task.userAssigned);
        if (task.label != null) {
          ref
              .read(taskLabelControllerProvider.notifier)
              .selectLabel(label: task.label!);
        }
      });
      return null;
    }, const []);

    final TaskLabelEnum? currentLabel = ref.watch(
      taskLabelControllerProvider.select((value) => value),
    );
    ref.listen(descriptionControllerProvider, (previous, next) {
      if (next != null && next.isNotEmpty) {
        descriptionController.text = next;
      }
    });

    final bool allFieldsAreValid = ref.watch(
      allEditFieldsAreValidControllerProvider(
        initialTitle: task.title,
        initialDescription: task.description,
        initialUserAssigned: task.userAssigned,
        initialLabel: task.label,
      ).select((value) => value),
    );

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: StringConstants.updateTaskTitle,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 34.0),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const TaskFormHeader(title: StringConstants.updateTaskTitle),
                const SizedBox(height: 40),
                const FieldSectionTitle(title: StringConstants.titleField),
                AdaptiveTextField(
                  controller: titleController,
                  hintText: StringConstants.titleHint,
                  isLarge: true,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => ref
                      .read(titleControllerProvider.notifier)
                      .updateTitle(title: value),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 30),
                const FieldSectionTitle(
                  title: StringConstants.generateDescriptionField,
                ),
                AdaptiveTextField(
                  controller: promptController,
                  hintText: StringConstants.generateDescriptionHint,
                  prefixIcon: const Icon(
                    Icons.auto_awesome,
                    color: Colors.purple,
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 15),
                GenerateWithIaButton(promptController: promptController),
                const SizedBox(height: 20),
                const FieldSectionTitle(
                  title: StringConstants.descriptionField,
                ),
                AdaptiveTextField(
                  controller: descriptionController,
                  hintText: StringConstants.descriptionHint,
                  prefixIcon: const Icon(
                    Icons.note_outlined,
                    color: Colors.grey,
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => ref
                      .read(descriptionControllerProvider.notifier)
                      .updateDescription(description: value),
                ),
                const SizedBox(height: 20),
                const FieldSectionTitle(title: StringConstants.userField),
                AdaptiveTextField(
                  controller: userAssignedController,
                  hintText: StringConstants.userHint,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => ref
                      .read(userAssignedControllerProvider.notifier)
                      .updateUserAssigned(user: value),
                ),
                const SizedBox(height: 20),
                const FieldSectionTitle(title: StringConstants.labelField),
                CustomDropdown<TaskLabelEnum>(
                  items: TaskLabelEnum.values,
                  value: task.label,
                  onChanged: (newLabel) {
                    if (newLabel != null) {
                      ref
                          .read(taskLabelControllerProvider.notifier)
                          .selectLabel(label: newLabel);
                    }
                  },
                  itemLabel: (item) => item.label,
                  hint: StringConstants.selectLabelHint,
                  prefixIcon: Icons.label_outline,
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: AdaptiveButton(
              onPressed: allFieldsAreValid
                  ? () {
                      ref
                          .read(taskListControllerProvider.notifier)
                          .updateTask(
                            updatedTask: Task(
                              description: descriptionController.text,
                              id: task.id,
                              isCompleted: task.isCompleted,
                              label: currentLabel ?? task.label,
                              status: task.status,
                              title: titleController.text,
                              userAssigned: userAssignedController.text,
                            ),
                          );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(StringConstants.taskUpdatedSuccess),
                          backgroundColor: Colors.green,
                        ),
                      );

                      context.pop();
                    }
                  : null,
              color: const Color(0xFF4A6CF7),
              borderRadius: BorderRadius.circular(12),
              child: Text(
                StringConstants.updateTaskTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
