import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_test/data_db/section_db.dart';

import 'package:sqflite_test/data_db/subject_db.dart';
import 'package:sqflite_test/data_db/video_db.dart';
import 'package:sqflite_test/data_db/word_db.dart';
export 'package:sqflite_test/data_db/subject_db.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //Path save DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'pruebaBD.db');
    print(path);

    //Create DB
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Subject(
          id INTEGER PRIMARY KEY,
          unit_name TEXT
        );
      ''');
      await db.execute('''
        CREATE TABLE Section(
          id INTEGER PRIMARY KEY,
          idSubject INTEGER,
          section_name TEXT
        );
      ''');
      await db.execute('''
        CREATE TABLE Word(
          id INTEGER PRIMARY KEY,
          idSection INTEGER,
          word TEXT
        );
      ''');
      await db.execute('''
        CREATE TABLE Video(
          id INTEGER PRIMARY KEY,
          idWord INTEGER,
          language TEXT
          url TEXT       
        );
      ''');
    });
  }

  // Future<int> newSubjectRaw(SubjectDto newSubject) async {
  //   final id = newSubject.id;
  //   final unitName = newSubject.unitName;

  //   //verifyDB
  //   final db = await database;

  //   final res = await db.rawInsert('''
  //     INSERT INTO Subject( id, unitName)
  //     VALUES ( $id, $unitName )
  //   ''');
  //   return res;
  // }
  Future<int> newSubject(SubjectDB newSubject) async {
    final db = await database;
    var x = await db
        .rawQuery('SELECT COUNT(*) from Subject WHERE id = ${newSubject.id}');
    int count = Sqflite.firstIntValue(x);
    if (count == 0) {
      final res = await db.insert('Subject', newSubject.toJson());
      return res;
    } else {
      return count;
    }
    //ID last item
  }

  Future<int> newSection(SectionDB newSection) async {
    final db = await database;
    var x = await db
        .rawQuery('SELECT COUNT(*) from Section WHERE id = ${newSection.id}');
    int count = Sqflite.firstIntValue(x);
    if (count == 0) {
      final res = await db.insert('Section', newSection.toJson());
      //ID last item
      return res;
    } else {
      return count;
    }
  }

  Future<int> newWord(WordDB newWord) async {
    final db = await database;
    var x =
        await db.rawQuery('SELECT COUNT(*) from Word WHERE id = ${newWord.id}');
    int count = Sqflite.firstIntValue(x);
    if (count == 0) {
      final res = await db.insert('Word', newWord.toJson());
      return res;
    } else {
      return count;
    }
  }

  Future<int> newVideo(VideoDB newVideo) async {
    final db = await database;
    var x = await db.rawQuery(
        'SELECT COUNT(*) from Video WHERE id = ${newVideo.id} AND id_word = ${newVideo.idWord}');
    int count = Sqflite.firstIntValue(x);
    if (count == 0) {
      final res = await db.insert('Video', newVideo.toJson());
      return res;
    } else {
      return count;
    }
  }

  Future<SubjectDB> getSubjectById(int id) async {
    final db = await database;
    final res = await db.query('Subject', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? SubjectDB.fromJson(res.first) : null;
  }

  Future<List<Map<String, dynamic>>> queryAll(int id) async {
    Database db = await database;
    return await db.query('Section', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getCountSubject(int id) async {
    //database connection
    Database db = await this.database;
    var x = await db.rawQuery('SELECT COUNT(*) from Subject WHERE id = $id');
    int count = Sqflite.firstIntValue(x);
    return count;
  }

  Future<List<SectionDB>> getSectionById(int id) async {
    final db = await database;
    final res = await db.query('Section', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? SectionDB.fromJson(res.first) : [];
  }

  Future<int> getWordByIdSection(int idSection) async {
    final db = await database;
    var x = await db
        .rawQuery('SELECT COUNT(*) from Word WHERE id_section = $idSection');
    int count = Sqflite.firstIntValue(x);
    return count;
  }

  Future<List<SubjectDB>> getAllSubjects() async {
    final db = await database;
    final res = await db.query('Subject');
    return res.isNotEmpty ? res.map((s) => SubjectDB.fromJson(s)).toList() : [];
  }

  Future<List<SectionDB>> getAllSections() async {
    final db = await database;
    final res = await db.query('Section');
    return res.isNotEmpty ? res.map((s) => SectionDB.fromJson(s)).toList() : [];
  }

  Future<List<WordDB>> getAllWords() async {
    final db = await database;
    final res = await db.query('Word');
    return res.isNotEmpty ? res.map((s) => WordDB.fromJson(s)).toList() : [];
  }

  Future<List<VideoDB>> getAllvideos() async {
    final db = await database;
    final res = await db.query('Video');
    return res.isNotEmpty ? res.map((s) => VideoDB.fromJson(s)).toList() : [];
  }

  Future<List<SubjectDB>> getSubjectsbyName(String name) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Subject WHERE unit_name = '$name'
    ''');
    return res.isNotEmpty ? res.map((s) => SubjectDB.fromJson(s)).toList() : [];
  }

  Future<int> updateSubject(SubjectDB newSubject) async {
    final db = await database;
    //without the where update all BD
    // final res = await db.update('Subject', newSubject.toJson());
    final res = await db.update('Subject', newSubject.toJson(),
        where: 'id = ?', whereArgs: [newSubject.id]);
    return res;
  }

  Future<int> deleteSubject(int id) async {
    final db = await database;
    final res = await db.delete('Subject', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllSubjects() async {
    final db = await database;
    final res = await db.delete('Subject');
    return res;
  }
}
