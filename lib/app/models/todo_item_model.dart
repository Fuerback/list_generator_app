import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

@JsonSerializable()
class ToDoItem {
  final String id, todoId;
  final String description;
  final int done;

  ToDoItem(this.description, {this.done = 0, String id, @required this.todoId})
      : this.id = id ?? Uuid().v4();

  ToDoItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        todoId = json['todo_id'],
        done = json['done'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'todo_id': todoId,
        'done': done,
        'description': description,
      };
}
