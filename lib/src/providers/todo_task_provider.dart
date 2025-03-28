import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_task.dart';
import '../models/list/todo_task_list.dart';

final todoListProvider =
    NotifierProvider<TodoTaskList, List<TodoTask>>(TodoTaskList.new);

final completedTodosCount = Provider<int>((ref) {
  return ref
      .watch(todoListProvider)
      .where((todo) => todo.completed == '1')
      .length;
});
