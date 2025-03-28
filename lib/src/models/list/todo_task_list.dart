import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/services/api_manager.dart';
import '../todo_task.dart';

class TodoTaskList extends Notifier<List<TodoTask>> {
  bool _isLoading = false; // Private variable to track loading state

  @override
  List<TodoTask> build() {
    // Initialize state with an empty list
    state = <TodoTask>[];
    fetchTodos(); // Fetch todos when the provider is built
    return state;
  }

  bool get isLoading => _isLoading; // Getter for loading state

  Future<void> fetchTodos() async {
    _isLoading = true; // Set loading to true
    state = state; // Notify listeners by setting the same state

    final List<TodoTask> allTasks = <TodoTask>[];
    int page = 0;
    List<TodoTask> fetchedTasks;

    do {
      fetchedTasks = await ApiManager().getTodos(page: page);
      allTasks.addAll(fetchedTasks);
      page++;
    } while (fetchedTasks.isNotEmpty);

    state = allTasks; // Update the state with the fetched tasks
    _isLoading = false; // Set loading to false
    state = state; // Notify listeners again to reflect the loading state change
  }

  void update(TodoTask task) {
    _isLoading = true; // Set loading to true
    state = state.map((TodoTask element) {
      if (element.id == task.id) {
        return task;
      }
      return element;
    }).toList();
    _isLoading = false; // Set loading to false
    state = state; // Notify listeners again to reflect the loading state change
  }
}
