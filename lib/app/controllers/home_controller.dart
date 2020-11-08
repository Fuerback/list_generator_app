import 'package:list_generator/app/db/db_provider.dart';
import 'package:list_generator/app/models/todo_model.dart';

class HomeController {
  DBProvider dbProvider = DBProvider.db;

  Future<List<ToDo>> getAllToDo() async {
    return await dbProvider.getAllToDo();
  }

  Future<int> insertTodo(ToDo toDo) async {
    return await dbProvider.insertTodo(toDo);
  }

  Future<int> updateTodo(ToDo todo) async {
    return dbProvider.updateTodo(todo);
  }
}
