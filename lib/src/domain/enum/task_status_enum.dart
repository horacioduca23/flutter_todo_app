enum TaskStatusEnum {
  pending(label: 'Pending'),
  completed(label: 'Completed');

  const TaskStatusEnum({required this.label});

  final String label;
}
