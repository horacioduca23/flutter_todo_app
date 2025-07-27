import '../../domain/task.dart';

abstract class HiveTaskDatasource {
  Future<void> addTask({required Task task});
  Future<Task?> getTask({required String id});
  Future<void> updateTask({required Task task});
  Future<void> deleteTask({required String id});
  Future<List<Task>> getTasks();
  Future<void> deleteAllTasks();
}
