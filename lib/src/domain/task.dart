import 'enum/task_label_enum.dart';
import 'enum/task_status_enum.dart';

final class Task {
  const Task({
    required this.description,
    required this.id,
    required this.isCompleted,
    required this.label,
    required this.status,
    required this.title,
    required this.userAssigned,
  });

  final String description;
  final String id;
  final bool isCompleted;
  final TaskLabelEnum? label;
  final TaskStatusEnum status;
  final String title;
  final String userAssigned;

  Task copyWith({
    String? description,
    String? id,
    bool? isCompleted,
    TaskLabelEnum? label,
    TaskStatusEnum? status,
    String? title,
    String? userAssigned,
  }) {
    return Task(
      description: description ?? this.description,
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      label: label ?? this.label,
      status: status ?? this.status,
      title: title ?? this.title,
      userAssigned: userAssigned ?? this.userAssigned,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, label: $label, status: $status, userAssigned: $userAssigned}';
  }
}
