import 'package:list_generator/app/db/db_provider.dart';
import 'package:list_generator/app/models/todo_item_model.dart';
import 'package:list_generator/app/models/todo_model.dart';

class ListDetailsController {
  DBProvider dbProvider = DBProvider.db;

  Future<int> insertItem(ToDoItem item) async {
    return await dbProvider.insertItem(item);
  }

  Future<List<ToDoItem>> getAllToDoItems(ToDo toDo) async {
    return await dbProvider.getAllToDoItems(toDo.id);
  }
}
