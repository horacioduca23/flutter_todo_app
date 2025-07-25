import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/constants/string_constants.dart';
import 'src/todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: StringConstants.dotEnv);

  //final sharedPreferences = await SharedPreferences.getInstance();

  runApp(const TodoApp());
}
