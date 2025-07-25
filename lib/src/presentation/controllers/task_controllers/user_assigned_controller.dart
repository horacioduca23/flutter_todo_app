import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_assigned_controller.g.dart';

@riverpod
class UserAssignedController extends _$UserAssignedController {
  @override
  String build() {
    return '';
  }

  void updateUserAssigned({required String user}) {
    state = user;
  }
}
