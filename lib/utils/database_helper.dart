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
  String _columnID = "id";
  String _columnText= "text";


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
    String path = join(directory.path,"Todo.db");

    var todoDB = await openDatabase(path, version: 1 , onCreate: _createDB);
    
    return todoDB;

  }
    
    
    
    
      FutureOr _createDB(Database db, int version) async  {
        await db.execute("CREATE TABLE $_todoTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT , $_columnText TEXT)");

  }
  Future<int> addTodo(ToDo_Item item) async{
    var db = await _getDatabase();
    var result = db.insert(_todoTablo, item.toMap());
    return result;
  }
  Future<List<Map<String , dynamic>>> allTodos()async {
    var db = await _getDatabase();
    var result = db.query(_todoTablo , orderBy: '$_columnID DESC');
    return result;
  }
Future<int> updateTodo(ToDo_Item item) async{
  var db = await _getDatabase();
  var result = db.update(_todoTablo, item.toMap() , where: '$_columnID = ? ' , whereArgs: [item.id]);
  return result;
}
Future<int> deleteTodo(int id) async{
  var db = await _getDatabase();
  print("////////////////////");
  
  var result = db.delete(_todoTablo,  where: '$_columnID = ? ' , whereArgs: [id]);
  
  return result;
}

Future deleteTable()async{
  var db = await _getDatabase();
  var result = db.delete(_todoTablo);
  
}

}