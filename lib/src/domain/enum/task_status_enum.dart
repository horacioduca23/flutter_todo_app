enum TaskStatusEnum {
  pending(label: 'Pendiente'),
  completed(label: 'Completada');

  const TaskStatusEnum({required this.label});

  final String label;
}
