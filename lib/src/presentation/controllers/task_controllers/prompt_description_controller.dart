import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prompt_description_controller.g.dart';

@riverpod
class PromptDescriptionController extends _$PromptDescriptionController {
  @override
  String build() => '';

  void updatePromptDescription({required String prompt}) {
    state = prompt;
  }
}
