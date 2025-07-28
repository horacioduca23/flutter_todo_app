enum TaskLabelEnum {
  work('Trabajo'),
  personal('Personal'),
  urgent('Urgente'),
  home('Hogar'),
  projects('Proyectos');

  const TaskLabelEnum(this.label);

  final String label;
}
