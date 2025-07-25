import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/enum/task_label_enum.dart';
import 'description_controller.dart';
import 'task_label_controller.dart';
import 'title_controller.dart';
import 'user_assigned_controller.dart';

part 'all_edit_fields_are_valid_controller.g.dart';

@riverpod
bool allEditFieldsAreValidController(
  AllEditFieldsAreValidControllerRef ref, {
  required String initialTitle,
  required String? initialDescription,
  required String initialUserAssigned,
  required TaskLabelEnum? initialLabel,
}) {
  final String title = ref.watch(titleControllerProvider);
  final String? description = ref.watch(descriptionControllerProvider);
  final String userAssigned = ref.watch(userAssignedControllerProvider);
  final TaskLabelEnum? label = ref.watch(taskLabelControllerProvider);

  final bool fieldsNotEmpty =
      title.trim().isNotEmpty &&
      description != null &&
      description.trim().isNotEmpty &&
      userAssigned.trim().isNotEmpty &&
      label != null;

  final bool hasChanged =
      title.trim() != initialTitle.trim() ||
      (description?.trim() ?? '') != (initialDescription ?? '').trim() ||
      userAssigned.trim() != initialUserAssigned.trim() ||
      label != initialLabel;

  return fieldsNotEmpty && hasChanged;
}
