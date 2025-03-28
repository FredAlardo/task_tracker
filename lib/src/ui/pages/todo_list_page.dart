import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker/src/models/todo_definition.dart';
import 'package:task_tracker/src/models/todo_task.dart';
import 'package:task_tracker/src/providers/todo_definition_provider.dart';
import 'package:task_tracker/src/utils/enums.dart';
import '../../providers/todo_task_provider.dart';

class TodoListPage extends ConsumerStatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  late TextEditingController _searchController;
  String _searchQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadSearchQuery(); // Load the search query when the page initializes
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller
    _debounce?.cancel(); // Cancel the debounce timer
    super.dispose();
  }

  Future<void> _loadSearchQuery() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchQuery = prefs.getString('searchQuery') ?? '';
      _searchController.text = _searchQuery;
    });
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      setState(() {
        _searchQuery = query;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('searchQuery', query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);
    final definitions = ref.watch(definitionListProvider);
    final isLoading = ref.watch(todoListProvider.notifier).isLoading ||
        ref.watch(definitionListProvider.notifier).isLoading;
    final filteredTodos = todos
        .where((todo) =>
            todo.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    final completedCount = ref.watch(completedTodosCount);
    final remainingCount = todos.length - completedCount;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text('Task Tracker'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildSearchField(),
                SizedBox(height: 8.0),
                Text('Completed: $completedCount, Pending: $remainingCount'),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildTodoList(filteredTodos, definitions),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        hintText: 'Search by title',
        border: OutlineInputBorder(),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: _clearSearch,
              )
            : null,
      ),
    );
  }

  Widget _buildTodoList(
      List<TodoTask> todos, List<TodoDefinition> definitions) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Card(
          color: todo.completed == '1'
              ? Colors.grey
              : definitions
                      .firstWhere((definition) => definition.type == todo.type)
                      .color
                      ?.displayColor ??
                  Colors.white,
          child: ListTile(
            title: Text(todo.title),
            subtitle: Text('Type: ${todo.type.displayName}'),
            trailing: Text(todo.completed == '1' ? 'Completed' : 'Pending'),
            onTap: () {
              // Navigate to details view
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Container()),
                // TodoDetailsScreen(todo: todo)),
              );
            },
          ),
        );
      },
    );
  }
}
