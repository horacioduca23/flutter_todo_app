import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/app_colors.dart';
import '../../constants/string_constants.dart';
import '../../core/platform/platform_utils.dart';
import '../../domain/enum/task_label_enum.dart';
import '../../domain/task.dart';
import '../controllers/task_controllers/description_controller.dart';
import '../controllers/task_controllers/prompt_description_controller.dart';
import '../controllers/task_controllers/task_label_controller.dart';
import '../controllers/task_controllers/title_controller.dart';
import '../controllers/task_controllers/user_assigned_controller.dart';
import 'adaptive/adaptive_text_field.dart';
import 'character_counter.dart';
import 'custom_dropdown.dart';
import 'field_section_title.dart';
import 'generate_with_ia_button.dart';

class TaskForm extends HookConsumerWidget {
  const TaskForm({super.key, this.initialTask, this.isEditMode = false});

  final Task? initialTask;
  final bool isEditMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(
      text: initialTask?.title ?? '',
    );
    final promptController = useTextEditingController();
    final descriptionController = useTextEditingController(
      text: initialTask?.description ?? '',
    );
    final userAssignedController = useTextEditingController(
      text: initialTask?.userAssigned ?? '',
    );

    final int titleCharacterCount = ref.watch(
      titleControllerProvider.select((title) => title.length),
    );
    final int promptCharacterCount = ref.watch(
      promptDescriptionControllerProvider.select(
        (description) => description.length,
      ),
    );
    final TaskLabelEnum? currentLabel = ref.watch(taskLabelControllerProvider);

    useMemoized(() {
      if (isEditMode && initialTask != null) {
        Future.microtask(() {
          ref
              .read(titleControllerProvider.notifier)
              .updateTitle(title: initialTask!.title);
          ref
              .read(descriptionControllerProvider.notifier)
              .updateDescription(description: initialTask!.description);
          ref
              .read(userAssignedControllerProvider.notifier)
              .updateUserAssigned(user: initialTask!.userAssigned);
          ref
              .read(taskLabelControllerProvider.notifier)
              .selectLabel(label: initialTask!.labelEnum);
        });
      }
    }, []);

    ref.listen(descriptionControllerProvider, (previous, next) {
      if (next != null &&
          next.isNotEmpty &&
          next != descriptionController.text) {
        descriptionController.text = next;
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldSectionTitle(title: StringConstants.titleField),
        AdaptiveTextField(
          controller: titleController,
          hintText: StringConstants.titleHint,
          isLarge: true,
          textInputAction: TextInputAction.next,
          maxLength: 50,
          onChanged: (value) => ref
              .read(titleControllerProvider.notifier)
              .updateTitle(title: value),
        ),
        CharacterCounter(currentLength: titleCharacterCount, maxLength: 50),
        const SizedBox(height: 30),
        Divider(color: AppColors.grey300, height: 1),
        const SizedBox(height: 30),
        const FieldSectionTitle(
          title: StringConstants.generateDescriptionField,
        ),
        AdaptiveTextField(
          controller: promptController,
          hintText: StringConstants.generateDescriptionHint,
          prefixIcon: isIOS
              ? const Icon(CupertinoIcons.sparkles, color: Colors.purple)
              : const Icon(Icons.auto_awesome, color: Colors.purple),
          textInputAction: TextInputAction.done,
          maxLength: 250,
          onChanged: (value) => ref
              .read(promptDescriptionControllerProvider.notifier)
              .updatePromptDescription(prompt: value),
        ),
        CharacterCounter(currentLength: promptCharacterCount, maxLength: 250),
        const SizedBox(height: 15),
        const GenerateWithIaButton(),
        const SizedBox(height: 20),
        const FieldSectionTitle(title: StringConstants.descriptionField),
        AdaptiveTextField(
          controller: descriptionController,
          hintText: StringConstants.descriptionHint,
          prefixIcon: isIOS
              ? const Icon(
                  CupertinoIcons.square_favorites_alt,
                  color: Colors.grey,
                )
              : const Icon(Icons.note_outlined, color: Colors.grey),
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
          prefixIcon: isIOS
              ? const Icon(CupertinoIcons.person, color: Colors.grey)
              : const Icon(Icons.person_outline, color: Colors.grey),
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
          prefixIcon: isIOS ? CupertinoIcons.tag : Icons.label_outline,
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}
