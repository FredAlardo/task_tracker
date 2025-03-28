import 'package:flutter/material.dart';

/// Enum for the type of todo.
enum TodoType {
  TODO,
  URGENT_TODO,
  TASK,
  CALL,
  ONLINE_MEETING,
  PHYSICAL_MEETING,
}

extension TodoTypeExtension on TodoType {
  String get displayName {
    switch (this) {
      case TodoType.TODO:
        return 'Todo';
      case TodoType.URGENT_TODO:
        return 'Urgent Todo';
      case TodoType.TASK:
        return 'Task';
      case TodoType.CALL:
        return 'Call';
      case TodoType.ONLINE_MEETING:
        return 'Online Meeting';
      case TodoType.PHYSICAL_MEETING:
        return 'Physical Meeting';
    }
  }
}

/// Enum for the style of todo.
enum TodoStyle {
  CHECKBOX,
  DEADLINE,
  SIMPLE,
}

/// Enum for the action associated with the todo.
enum TodoAction {
  COMPLETE_TODO,
  COMPLETE_TASK,
  COMPLETE_CALL,
  COMPLETE_MEETING,
}

/// Enum for the colors associated with todos.
enum TodoColor {
  BLUE,
  RED,
  GREEN,
  YELLOW,
  ORANGE,
  GREY,
  WHITE,
}

/// Extension to map TodoColor to Color objects.
extension TodoColorExtension on TodoColor {
  Color get displayColor {
    switch (this) {
      case TodoColor.BLUE:
        return Colors.blue.withAlpha(180);
      case TodoColor.RED:
        return Colors.red.withAlpha(180);
      case TodoColor.GREEN:
        return Colors.green.withAlpha(180);
      case TodoColor.YELLOW:
        return Colors.yellow.withAlpha(180);
      case TodoColor.ORANGE:
        return Colors.orange.withAlpha(180);
      case TodoColor.GREY:
        return Colors.grey.withAlpha(180);
      case TodoColor.WHITE:
        return Colors.white;
    }
  }
}
