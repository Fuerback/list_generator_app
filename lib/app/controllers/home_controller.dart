import 'package:list_generator/app/db/db_provider.dart';
import 'package:list_generator/app/models/todo_model.dart';

class HomeController {
  DBProvider dbProvider = DBProvider.db;

  Future<List<ToDo>> getAllToDo() async {
    var allToDo = await dbProvider.getAllToDo();
    sortLists(allToDo);
    return allToDo;
  }

  Future<int> insertTodo(ToDo toDo) async {
    return await dbProvider.insertTodo(toDo);
  }

  Future<int> updateTodo(ToDo todo) async {
    return dbProvider.updateTodo(todo);
  }

  void sortLists(List<ToDo> lists) {
    lists.sort((a, b) {
      if (b.isStarred && !a.isStarred)
        return 1;
      else if (!b.isStarred && a.isStarred)
        return -1;
      else
        return 0;
    });
  }
}
