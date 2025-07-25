import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'description_controller.g.dart';

@riverpod
class DescriptionController extends _$DescriptionController {
  @override
  String? build() {
    return null;
  }

  void updateDescription({required String description}) {
    state = description;
  }
}
