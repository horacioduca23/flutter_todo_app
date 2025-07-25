import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/enum/task_label_enum.dart';

part 'task_label_controller.g.dart';

@riverpod
class TaskLabelController extends _$TaskLabelController {
  @override
  TaskLabelEnum? build() {
    return null;
  }

  void selectLabel({required TaskLabelEnum label}) {
    state = label;
  }
}
