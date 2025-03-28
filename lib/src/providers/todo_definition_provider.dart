import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/src/models/list/todo_definition_list.dart';
import 'package:task_tracker/src/models/todo_definition.dart';

final definitionListProvider =
    NotifierProvider<TodoDefinitionList, List<TodoDefinition>>(
        TodoDefinitionList.new);
