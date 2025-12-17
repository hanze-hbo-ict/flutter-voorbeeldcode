import 'package:database_app/models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'todos.db';
  static const _version = 1;
  static const _tableName = 'todo';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    print(path);
    return await openDatabase(path, version: _version,
        onCreate: (db, version) async {
      db.execute(''' CREATE TABLE $_tableName (
        userID integer,
        id integer primary key,
        title text,
        completed enum(0,1)
      )
    ''');
    });
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await instance.database;
    try {
      return await db.insert(_tableName, todo.toJson());
    } on DatabaseException {
      fetchTodo(todo.id);
      throw Exception('todo met id ${todo.id} was al opgeslagen');
    }
  }

  Future<List<Todo>> readAllTodos() async {
    Database db = await instance.database;
    var todos = await db.query(_tableName);
    return todos.isNotEmpty
        ? todos.map((el) => Todo.fromJson(el)).toList()
        : [];
  }

  fetchTodo(int id) async {
    Database db = await instance.database;
    List<Map> result = await db.query(_tableName,
        columns: ['userId', 'id', 'title', 'completed'],
        where: 'id=?',
        whereArgs: [id]);
    result.forEach((row) => print(row));
    // return result;
  }
}
