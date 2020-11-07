import 'package:list_generator/app/models/todo_item_model.dart';
import 'package:list_generator/app/models/todo_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBProvider {
  static Database _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  get _dbPath async {
    String documentsDirectory = await _localPath;
    return path.join(documentsDirectory, "todotest.db");
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  initDB() async {
    String path = await _dbPath;
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print("DBProvider:: onCreate()");
      await db.execute("CREATE TABLE Todo ("
          "id TEXT PRIMARY KEY,"
          "name TEXT,"
          "starred INTEGER NOT NULL DEFAULT 0"
          ")");
      await db.execute("CREATE TABLE Item ("
          "id TEXT PRIMARY KEY,"
          "description TEXT,"
          "todo_id TEXT,"
          "done INTEGER NOT NULL DEFAULT 0"
          ")");
    });
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<List<ToDoItem>> getAllToDoItems() async {
    final db = await database;
    var result = await db.query('Item');
    return result.map((it) => ToDoItem.fromJson(it)).toList();
  }

  Future<List<ToDo>> getAllToDo() async {
    final db = await database;
    var result = await db.query('Todo');
    return result.map((it) => ToDo.fromJson(it)).toList();
  }

  Future<int> updateTodo(ToDo todo) async {
    final db = await database;
    return db
        .update('Todo', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> removeTodo(ToDo todo) async {
    final db = await database;
    return db.transaction<void>((txn) async {
      await txn.delete('Todo', where: 'id = ?', whereArgs: [todo.id]);
      await txn.delete('Item', where: 'todo_id = ?', whereArgs: [todo.id]);
    });
  }

  Future<int> insertTodo(ToDo todo) async {
    final db = await database;
    return db.insert('Todo', todo.toJson());
  }

  Future<int> insertItem(ToDoItem item) async {
    final db = await database;
    return db.insert('Item', item.toJson());
  }

  Future<int> removeItem(ToDoItem item) async {
    final db = await database;
    return db.delete('Item', where: 'id = ?', whereArgs: [item.id]);
  }

  Future<int> updateTask(ToDoItem item) async {
    final db = await database;
    return db
        .update('Task', item.toJson(), where: 'id = ?', whereArgs: [item.id]);
  }
}
