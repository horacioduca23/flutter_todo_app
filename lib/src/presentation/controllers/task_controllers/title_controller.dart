import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'title_controller.g.dart';

@riverpod
class TitleController extends _$TitleController {
  @override
  String build() {
    return '';
  }

  void updateTitle({required String title}) {
    state = title;
  }
}
