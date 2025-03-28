import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/src/ui/pages/todo_list_page.dart';

void main() {
  runApp(const ProviderScope(
    child: TaskTrackerApp(),
  ));
}

class TaskTrackerApp extends StatelessWidget {
  const TaskTrackerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListPage(),
    );
  }
}
