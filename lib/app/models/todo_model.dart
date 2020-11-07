import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

@JsonSerializable()
class ToDo {
  String id, name;
  int starred;

  ToDo({@required this.name, this.starred = 0, String id})
      : this.id = id ?? Uuid().v4();

  ToDo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        starred = json['starred'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'starred': starred,
      };
}
