import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/constants/string_constants.dart';
import 'src/data/datasources/hive_task_datasource.impl.dart';
import 'src/domain/task.dart';
import 'src/todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: StringConstants.dotEnv);

  await Hive.initFlutter();

  Hive.registerAdapter<Task>(TaskAdapter());

  await Hive.openBox<Task>(HiveTaskDatasourceImpl.boxName);

  runApp(const TodoApp());
}
