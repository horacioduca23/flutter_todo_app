import 'package:flutter/material.dart';

import 'src/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const TodoApp(),
  );
}
