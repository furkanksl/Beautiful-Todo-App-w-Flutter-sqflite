import 'dart:async';
import 'dart:io';
import 'package:My_Todo_App/model/todo_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;
  String _todoTablo = "todo";
  String _todoShop ="shop";
  String _todoOther = "other";
  String _todoEdu = "education";
  String _columnID = "id";
  String _columnText= "text";
  String _columnTitle = "title";
  String _columnOther= "other";

  DatabaseHelper._internal();

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      return _databaseHelper = DatabaseHelper._internal();
    }else{
      return _databaseHelper;
    }
  }
  Future<Database>_getDatabase() async {

    if(_database == null){
      _database = await _initialDatabase();
    }

    return _database;
  }
  _initialDatabase() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,"NYMM15.db");

    var todoDB = await openDatabase(path, version: 1 , onCreate: _createDB);
    
    return todoDB;

  }
      FutureOr _createDB(Database db, int version) async  {
        await db.execute("CREATE TABLE $_todoTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT ,$_columnTitle  TEXT , $_columnText TEXT , $_columnOther TEXT)");
        await db.execute("CREATE TABLE $_todoShop ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT ,$_columnTitle  TEXT , $_columnText TEXT , $_columnOther TEXT)");
        await db.execute("CREATE TABLE $_todoOther ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT ,$_columnTitle  TEXT , $_columnText TEXT , $_columnOther TEXT)");
        await db.execute("CREATE TABLE $_todoEdu ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT ,$_columnTitle  TEXT , $_columnText TEXT , $_columnOther TEXT)");

  }
  Future<int> addTodoNotes(ToDo_Item item) async{
    var db = await _getDatabase();
    var result = db.insert(_todoTablo, item.toMap());
    return result;
  }
  Future<int> addTodoShop(ToDo_Item item) async{
    var db = await _getDatabase();
    var result = db.insert(_todoShop, item.toMap());
    return result;
  }
  Future<int> addTodoOther(ToDo_Item item) async{
    var db = await _getDatabase();
    var result = db.insert(_todoOther, item.toMap());
    return result;
  }
  Future<int> addTodoEdu(ToDo_Item item) async{
    var db = await _getDatabase();
    var result = db.insert(_todoEdu, item.toMap());
    return result;
  }

  
  
  Future<List<Map<String , dynamic>>> allTodos()async {
    var db = await _getDatabase();
    var result = db.query(_todoTablo , orderBy: '$_columnID DESC');
    return result;
  }
  Future<List<Map<String , dynamic>>> allTodosShop()async {
    var db = await _getDatabase();
    var result = db.query(_todoShop , orderBy: '$_columnID DESC');
    return result;
  }
  Future<List<Map<String , dynamic>>> allTodosOther()async {
    var db = await _getDatabase();
    var result = db.query(_todoOther , orderBy: '$_columnID DESC');
    return result;
  }
  Future<List<Map<String , dynamic>>> allTodosEdu()async {
    var db = await _getDatabase();
    var result = db.query(_todoEdu , orderBy: '$_columnID DESC');
    return result;
  }



Future<int> updateTodo(ToDo_Item item) async{
  var db = await _getDatabase();
  var result = db.update(_todoTablo, item.toMap() , where: '$_columnID = ? ' , whereArgs: [item.id]);
  return result;
}




Future<int> deleteTodo(int id) async{
  var db = await _getDatabase();

  var result = db.delete(_todoTablo,  where: '$_columnID = ? ' , whereArgs: [id]);
  
  return result;
}

Future<int> deleteTodoShop(int id) async{
  var db = await _getDatabase();

  var result = db.delete(_todoShop,  where: '$_columnID = ? ' , whereArgs: [id]);
  
  return result;
}
Future<int> deleteTodoOther(int id) async{
  var db = await _getDatabase();

  var result = db.delete(_todoOther,  where: '$_columnID = ? ' , whereArgs: [id]);
  
  return result;
}
Future<int> deleteTodoEdu(int id) async{
  var db = await _getDatabase();

  var result = db.delete(_todoEdu,  where: '$_columnID = ? ' , whereArgs: [id]);
  
  return result;
}



Future deleteTable()async{
  var db = await _getDatabase();
  var result = db.delete(_todoTablo);
  
}

}