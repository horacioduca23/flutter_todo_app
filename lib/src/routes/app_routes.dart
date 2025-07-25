enum AppRoutes {
  home('/', 'home'),
  addTask('add-task', 'add-task'),
  editTask('edit-task', 'edit-task');

  const AppRoutes(this.path, this.name);

  final String path;
  final String name;
}
