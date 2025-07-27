import 'package:hive/hive.dart';

import '../../domain/task.dart';
import 'hive_task_datasource.dart';

class HiveTaskDatasourceImpl implements HiveTaskDatasource {
  HiveTaskDatasourceImpl();

  static String get boxName => _boxName;

  static const String _boxName = 'tasks';

  final Box<Task> _box = Hive.box<Task>(_boxName);

  @override
  Future<void> addTask({required Task task}) async =>
      await _box.put(task.id, task);

  @override
  Future<Task?> getTask({required String id}) async => _box.get(id);

  @override
  Future<void> updateTask({required Task task}) async {
    await _box.put(task.id, task);
  }

  @override
  Future<void> deleteTask({required String id}) async => await _box.delete(id);

  @override
  Future<List<Task>> getTasks() async => _box.values.toList();

  @override
  Future<void> deleteAllTasks() async => await _box.clear();
}
