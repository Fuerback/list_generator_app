import 'package:list_generator/app/db/db_provider.dart';
import 'package:list_generator/app/models/todo_item_model.dart';
import 'package:list_generator/app/models/todo_model.dart';

class ListDetailsController {
  DBProvider dbProvider = DBProvider.db;

  Future<int> insertItem(ToDoItem item) async {
    return await dbProvider.insertItem(item);
  }

  Future<List<ToDoItem>> getAllToDoItems(ToDo toDo) async {
    var allItems = await dbProvider.getAllToDoItems(toDo.id);
    sortItems(allItems);
    return allItems;
  }

  Future<int> updateTask(ToDoItem item) async {
    return dbProvider.updateTask(item);
  }

  void sortItems(List<ToDoItem> items) {
    items.sort((a, b) {
      if (a.isDone && !b.isDone)
        return 1;
      else if (!a.isDone && b.isDone)
        return -1;
      else
        return 0;
    });
  }
}
