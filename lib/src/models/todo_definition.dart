import 'package:flutter/foundation.dart';
import 'package:task_tracker/src/utils/enums.dart';

/// Represents the definition of a todo with its attributes.
@immutable
class TodoDefinition {
  /// Creates a new instance of [TodoDefinition].
  const TodoDefinition({
    required this.type,
    required this.style,
    required this.color,
    required this.action,
  });

  /// Factory method to create a [TodoDefinition] from a JSON map.
  factory TodoDefinition.fromJson(Map<String, dynamic> json) {
    return TodoDefinition(
      type: TodoType.values.firstWhere(
        (TodoType type) => type.name == json['type'] as String,
        orElse: () => TodoType.TODO,
      ),
      style: TodoStyle.values.firstWhere(
        (TodoStyle style) => style.name == json['style'] as String,
        orElse: () => TodoStyle.SIMPLE,
      ),
      color: json['color'] != null
          ? TodoColor.values.firstWhere(
              (TodoColor color) => color.name == json['color'] as String,
              orElse: () => TodoColor.WHITE,
            )
          : null,
      action: TodoAction.values.firstWhere(
          (TodoAction action) => action.name == json['action'] as String,
          orElse: () => TodoAction.COMPLETE_TODO),
    );
  }

  /// The type of the todo.
  final TodoType type;

  /// The style of the todo (e.g., CHECKBOX, DEADLINE, SIMPLE).
  final TodoStyle style;

  /// The color associated with the todo, if applicable.
  final TodoColor? color;

  /// The action associated with the todo (e.g., COMPLETE_TODO).
  final TodoAction action;

  /// Converts the [TodoDefinition] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'style': style.toString(),
      'color': color.toString(),
      'action': action.toString(),
    };
  }
}
