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

class EditTaskScreen extends HookConsumerWidget {
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
    final TextEditingController titleController = useTextEditingController(
      text: task.title,
    );
    final TextEditingController promptController = useTextEditingController();
    final TextEditingController descriptionController =
        useTextEditingController(text: task.description);
    final TextEditingController userAssignedController =
        useTextEditingController(text: task.userAssigned);

    useMemoized(() {
      Future.microtask(() {
        ref
            .read(titleControllerProvider.notifier)
            .updateTitle(title: task.title);
        ref
            .read(descriptionControllerProvider.notifier)
            .updateDescription(description: task.description);
        ref
            .read(userAssignedControllerProvider.notifier)
            .updateUserAssigned(user: task.userAssigned);

        ref
            .read(taskLabelControllerProvider.notifier)
            .selectLabel(label: task.labelEnum);
      });
    }, []);

    final TaskLabelEnum? currentLabel = ref.watch(taskLabelControllerProvider);

    ref.listen(descriptionControllerProvider, (previous, next) {
      if (next != null &&
          next.isNotEmpty &&
          next != descriptionController.text) {
        descriptionController.text = next;
      }
    });

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
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 34.0),
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
                  maxLength: 50,
                  showCounter: false,
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
                  maxLength: 250,
                  showCounter: false,
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
                  value: currentLabel,
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
        onPressed: allFieldsAreValid
            ? () {
                ref
                    .read(taskListControllerProvider.notifier)
                    .updateTask(
                      task: task.copyWith(
                        description: descriptionController.text,
                        label: currentLabel,
                        title: titleController.text,
                        userAssigned: userAssignedController.text,
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
