import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/string_constants.dart';
import '../../../domain/enum/task_label_enum.dart';
import '../../../domain/enum/task_status_enum.dart';
import '../../../domain/task.dart';
import '../../controllers/home_controllers/task_list_controller.dart';
import '../../controllers/task_controllers/all_fields_are_valid_controller.dart';
import '../../controllers/task_controllers/description_controller.dart';
import '../../controllers/task_controllers/prompt_description_controller.dart';
import '../../controllers/task_controllers/task_label_controller.dart';
import '../../controllers/task_controllers/title_controller.dart';
import '../../controllers/task_controllers/user_assigned_controller.dart';
import '../../widgets/adaptive/adaptive_app_bar.dart';
import '../../widgets/adaptive/adaptive_scaffold.dart';
import '../../widgets/adaptive/adaptive_snack_bar.dart';
import '../../widgets/adaptive_text_field.dart';
import '../../widgets/character_counter.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/field_section_title.dart';
import '../../widgets/generate_with_ia_button.dart';
import '../../widgets/task_bottom_bar.dart';
import '../../widgets/task_form_header.dart';

class AddTaskScreen extends HookConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = useTextEditingController();
    final TextEditingController promptController = useTextEditingController();
    final TextEditingController descriptionController =
        useTextEditingController();
    final TextEditingController userAssignedController =
        useTextEditingController();
    final TaskLabelEnum? label = ref.watch(taskLabelControllerProvider);
    final bool areAllFieldsFilled = ref.watch(
      allFieldsAreValidControllerProvider,
    );
    ref.listen(descriptionControllerProvider, (previous, next) {
      if (next != null && next.isNotEmpty) {
        descriptionController.text = next;
      }
    });

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: StringConstants.addTaskTitle,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 34.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const TaskFormHeader(title: StringConstants.addTaskTitle),
                const SizedBox(height: 40),
                const FieldSectionTitle(title: StringConstants.titleField),
                AdaptiveTextField(
                  controller: titleController,
                  hintText: StringConstants.titleHint,
                  isLarge: true,
                  textInputAction: TextInputAction.next,
                  showCounter: false,
                  maxLength: 50,
                  onChanged: (value) => ref
                      .read(titleControllerProvider.notifier)
                      .updateTitle(title: value),
                ),
                CharacterCounter(
                  currentLength: titleController.text.length,
                  maxLength: 50,
                ),
                const SizedBox(height: 30),
                Divider(color: Colors.grey[300], height: 1),
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
                  showCounter: false,
                  maxLength: 250,
                  onChanged: (value) => ref
                      .read(promptDescriptionControllerProvider.notifier)
                      .updatePromptDescription(prompt: value),
                ),
                CharacterCounter(
                  currentLength: promptController.text.length,
                  maxLength: 250,
                ),
                const SizedBox(height: 15),
                const GenerateWithIaButton(),
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
                  value: label,
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
      bottomNavigationBar: TaskBottomBar(
        title: StringConstants.addTaskButton,
        onPressed: areAllFieldsFilled && label != null
            ? () {
                ref
                    .read(taskListControllerProvider.notifier)
                    .addTask(
                      task: Task(
                        description: descriptionController.text,
                        id: DateTime.now().toString(),
                        isCompleted: false,
                        label: label.name,
                        status: TaskStatusEnum.pending.name,
                        title: titleController.text,
                        userAssigned: userAssignedController.text,
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
