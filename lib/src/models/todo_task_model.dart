/// Represents a task with various attributes related to its details and status.
class TodoTask {
  /// Creates a new instance of [TodoTask].
  TodoTask({
    required this.title,
    required this.id,
    required this.type,
    required this.description,
    required this.completed,
    this.dueDate,
    this.startTime,
    this.finishTime,
    this.phone,
    this.url,
    this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create a [TodoTask] from a JSON map.
  ///
  /// The [json] parameter is expected to contain the keys that match the
  /// properties of the [TodoTask] class. This method will throw an error if
  /// the required keys are not present in the JSON map.
  factory TodoTask.fromJson(Map<String, dynamic> json) {
    return TodoTask(
      title: json['title'] as String,
      id: json['id'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      completed: json['completed'] as String,
      dueDate: json['due_date'] as String?,
      startTime: json['start_time'] as String?,
      finishTime: json['finish_time'] as String?,
      phone: json['phone'] as String?,
      url: json['url'] as String?,
      location: json['location'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  /// The title of the task.
  final String title;

  /// The unique identifier for the task.
  final String id;

  /// The type of the task (e.g., URGENT_TODO, ONLINE_MEETING).
  final String type;

  /// A brief description of the task.
  final String description;

  /// Indicates whether the task is completed (0 for no, 1 for yes).
  final String completed;

  /// The due date for the task, if applicable.
  final String? dueDate;

  /// The start time for the task, if applicable.
  final String? startTime;

  /// The finish time for the task, if applicable.
  final String? finishTime;

  /// The phone number associated with the task, if applicable.
  final String? phone;

  /// A URL related to the task, if applicable.
  final String? url;

  /// The location associated with the task, if applicable.
  final String? location;

  /// The timestamp when the task was created.
  final String createdAt;

  /// The timestamp when the task was last updated.
  final String updatedAt;

  /// Converts the [TodoTask] instance to a JSON map.
  ///
  /// This method is useful for serializing the task data to be sent to
  /// an API or saved in local storage.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'type': type,
      'description': description,
      'completed': completed,
      'due_date': dueDate,
      'start_time': startTime,
      'finish_time': finishTime,
      'phone': phone,
      'url': url,
      'location': location,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
