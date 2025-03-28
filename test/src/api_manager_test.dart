import 'package:flutter_test/flutter_test.dart';
import 'package:task_tracker/src/models/todo_task.dart';
import 'package:task_tracker/src/utils/services/api_manager.dart';

void main() {
  group('ApiManager', () {
    late ApiManager apiManager;

    setUp(() {
      apiManager = ApiManager();
    });

    test('getTodos returns a list of TodoTask', () async {
      // Act
      final List<TodoTask> todos = await apiManager.getTodos();

      // Assert
      expect(todos, isA<List<TodoTask>>());
      expect(todos.isNotEmpty, true); // Ensure that the list is not empty
    });

    test('getTodos returns an empty list when the response is empty', () async {
      // Act
      final List<TodoTask> todos = await apiManager.getTodos(
          page: 100); // Assuming page 100 returns no data

      // Assert
      expect(todos, isA<List<TodoTask>>());
      expect(todos.isEmpty, true); // Ensure that the list is empty
    });

    test('getTodoById returns a TodoTask', () async {
      // Act
      final TodoTask? todo =
          await apiManager.getTodoById('1'); // Replace '1' with a valid ID

      // Assert
      expect(todo, isA<TodoTask>());
      expect(todo?.id, '1'); // Ensure that the ID matches
    });

    test('getDefinition returns a list of action definitions', () async {
      // Act
      final List<dynamic>? definitions = await apiManager.getDefinition();

      // Assert
      expect(definitions, isA<List<dynamic>>());
      expect(definitions != null && definitions.isNotEmpty,
          true); // Ensure that the list is not empty
    });

    test('performAction does not throw an exception', () async {
      // Act
      expect(() async => apiManager.performAction('1', 'actionKey'),
          returnsNormally); // Replace '1' and 'actionKey' with valid values
    });
  });
}
