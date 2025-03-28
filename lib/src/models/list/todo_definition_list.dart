import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/src/models/todo_definition.dart';
import '../../utils/services/api_manager.dart';

class TodoDefinitionList extends Notifier<List<TodoDefinition>> {
  bool _isLoading = false; // Private variable to track loading state

  @override
  List<TodoDefinition> build() {
    // Initialize state with an empty list
    state = <TodoDefinition>[];
    fetchTodos(); // Fetch todos when the provider is built
    return state;
  }

  bool get isLoading => _isLoading; // Getter for loading state

  Future<void> fetchTodos() async {
    _isLoading = true; // Set loading to true
    state = state; // Notify listeners by setting the same state

    final List<TodoDefinition> allDefinitions = <TodoDefinition>[];
    List<TodoDefinition> fetchedDefinitions;

    fetchedDefinitions = await ApiManager().getDefinition() ?? [];
    allDefinitions.addAll(fetchedDefinitions);

    state = allDefinitions; // Update the state with the fetched tasks
    _isLoading = false; // Set loading to false
    state = state; // Notify listeners again to reflect the loading state change
  }
}
