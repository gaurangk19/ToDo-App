import 'package:sqflite/sqflite.dart'; // sqflite for database
import 'package:path/path.dart'; // the path package
import './todo_model.dart'; // the todo model we created before

class DatabaseConnect {
  Database? _database;


  Future<Database> get database async {

    final dbpath = await getDatabasesPath();

    const dbname = 'todo.db';

    final path = join(dbpath, dbname);


    _database = await openDatabase(path, version: 1, onCreate: _createDB);


    return _database!;
  }


  // this creates Tables in our database
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
    ''');
  }

  // function to add data into our database
  Future<void> insertTodo(Todo todo) async {
    // get the connection to database
    final db = await database;
    // insert the todo
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm:
      ConflictAlgorithm.replace,
    );
  }

  // function to delete a  todo from our database
  Future<void> deleteTodo(Todo todo) async {
    final db = await database;

    await db.delete(
      'todo',
      where: 'id == ?',
      whereArgs: [todo.id],
    );
  }

  // function to fetch all the todo data from our database
  Future<List<Todo>> getTodo() async {
    final db = await database;
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
    );

    return List.generate(
      items.length,
          (i) => Todo(
        id: items[i]['id'],
        title: items[i]['title'],
        creationDate: DateTime.parse(items[i][
        'creationDate']), // this is in Text format right now. let's convert it to dateTime format
        isChecked: items[i]['isChecked'] == 1
            ? true
            : false, // this will convert the Integer to boolean. 1 = true, 0 = false.
      ),
    );
  }

  // function for updating a todo in todoList
  Future<void> updateTodo(int id, String title) async {
    final db = await database;

    await db.update(
      'todo', // table name
      {
        //
        'title': title, // data we have to update
      }, //
      where: 'id == ?', // which Row we have to update
      whereArgs: [id],
    );
  }
}