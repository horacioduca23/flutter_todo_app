import 'package:flutter_todo_app/src/data/datasources/hive_task_datasource.dart';

import '../../domain/task.dart';

class HiveTaskRepository {
  HiveTaskRepository({required HiveTaskDatasource hiveTaskDatasource})
    : _hiveTaskDatasource = hiveTaskDatasource;

  final HiveTaskDatasource _hiveTaskDatasource;

  Future<void> addTask({required Task task}) async =>
      await _hiveTaskDatasource.addTask(task: task);

  Future<Task?> getTask({required String id}) async =>
      await _hiveTaskDatasource.getTask(id: id);

  Future<void> updateTask({required Task task}) async =>
      await _hiveTaskDatasource.updateTask(task: task);

  Future<void> deleteTask({required String id}) async =>
      await _hiveTaskDatasource.deleteTask(id: id);

  Future<List<Task>> getTasks() async => await _hiveTaskDatasource.getTasks();

  Future<void> deleteAllTasks() async =>
      await _hiveTaskDatasource.deleteAllTasks();
}
