import 'package:hive/hive.dart';

import 'enum/task_label_enum.dart';
import 'enum/task_status_enum.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  const Task({
    required this.description,
    required this.id,
    required this.isCompleted,
    required this.label,
    required this.status,
    required this.title,
    required this.userAssigned,
  });

  @HiveField(0)
  final String description;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final bool isCompleted;

  @HiveField(3)
  final String? label;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final String title;

  @HiveField(6)
  final String userAssigned;

  TaskLabelEnum get labelEnum {
    return TaskLabelEnum.values.firstWhere(
      (e) => e.name == label,
      orElse: () => TaskLabelEnum.personal,
    );
  }

  TaskStatusEnum get statusEnum {
    return TaskStatusEnum.values.firstWhere(
      (e) => e.name == status,
      orElse: () => TaskStatusEnum.pending,
    );
  }

  factory Task.create({
    required String description,
    required String id,
    required bool isCompleted,
    required TaskLabelEnum? label,
    required TaskStatusEnum status,
    required String title,
    required String userAssigned,
  }) {
    return Task(
      description: description,
      id: id,
      isCompleted: isCompleted,
      label: label?.name,
      status: status.name,
      title: title,
      userAssigned: userAssigned,
    );
  }

  Task copyWith({
    String? description,
    String? id,
    bool? isCompleted,
    TaskLabelEnum? label,
    TaskStatusEnum? status,
    String? title,
    String? userAssigned,
  }) {
    return Task.create(
      description: description ?? this.description,
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      label: label ?? labelEnum,
      status: status ?? statusEnum,
      title: title ?? this.title,
      userAssigned: userAssigned ?? this.userAssigned,
    );
  }
}
