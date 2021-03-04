import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'gameDatabase.db';
  static final _dbVersion = 1;
  static final _tableSubject = 'subject';
  static final _tableSection = 'section';

  static final columnId = '_id';
  static final columnName = 'name';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute('''


//CUADRAR ATRIBUTOS Y TABLAS PARA EDGEUP

      CREATE TABLE $_tableSubject(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL)

      ''');
    db.execute('''

      CREATE TABLE $_tableSection(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL)

      ''');
  }

  // {
  //   "_id":12,
  //   "name":"Test"
  // }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableSubject, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableSubject);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(_tableSubject, row, where: '$columnId = ? ', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(_tableSubject, where: '$columnId = ?', whereArgs: [id]);
  }
}
