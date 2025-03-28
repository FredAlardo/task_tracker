import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_tracker/src/models/todo_definition.dart';
import '../../models/todo_task.dart';

/// A class to manage API interactions for the Todo application.
class ApiManager {
  // Factory method to return the instance
  factory ApiManager() {
    return _instance;
  }
  // Private constructor
  ApiManager._();

  // Static instance
  static final ApiManager _instance = ApiManager._();

  static const String _baseUrl = 'https://my.api.mockaroo.com';
  static const String _apiKey = 'fac54c20';

  /// Sends a GET request to the specified endpoint and returns the response.
  ///
  /// Throws an exception if the response status code is not 200.
  Future<http.Response> _get(String endpoint) async {
    final http.Response response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: <String, String>{
        'X-API-Key': _apiKey,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load data from $endpoint');
    }
    return response;
  }

  /// Retrieves a list of todos with pagination.
  ///
  /// [page] specifies the page number to retrieve.
  /// Returns a list of [TodoTask] objects.
  Future<List<TodoTask>> getTodos({int page = 0}) async {
    final http.Response response = await _get('/todos?page=$page');

    if (response.body.isEmpty) {
      return <TodoTask>[]; // Return an empty list if no todos are found
    }

    final List<dynamic> jsonResponse =
        json.decode(response.body) as List<dynamic>;
    return jsonResponse
        .map((dynamic json) => TodoTask.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Retrieves a todo by its ID.
  ///
  /// [id] is the unique identifier of the todo.
  /// Returns the corresponding [TodoTask] object or null if not found.
  Future<TodoTask?> getTodoById(String id) async {
    final http.Response response = await _get('/todos/$id');

    if (response.body.isEmpty) {
      return null; // Return null if the response is empty
    }

    final List<dynamic> jsonResponse =
        json.decode(response.body) as List<dynamic>;
    return TodoTask.fromJson(jsonResponse[0] as Map<String, dynamic>);
  }

  /// Retrieves the definition of actions available for todos.
  ///
  /// Returns a list of action definitions or null if no definitions are found.
  Future<List<TodoDefinition>?> getDefinition() async {
    final http.Response response = await _get('/todo/definition');

    if (response.body.isEmpty) {
      return null; // Return null if the response is empty
    }

    final List<dynamic> jsonResponse =
        json.decode(response.body) as List<dynamic>;
    return jsonResponse
        .map((dynamic json) =>
            TodoDefinition.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Performs an action on a todo.
  ///
  /// [todoId] is the ID of the todo to perform the action on.
  /// [actionKey] is the key representing the action to be performed.
  Future<void> performAction(String todoId, String actionKey) async {
    final http.Response response = await http.post(
      Uri.parse('$_baseUrl/todo/action'),
      headers: <String, String>{
        'X-API-Key': _apiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode(<String, String>{
        'task': todoId,
        'action': actionKey,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to perform action');
    }
  }
}
