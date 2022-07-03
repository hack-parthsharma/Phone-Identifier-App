import 'dart:core';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
//i tried storing data locally using sqflite database...  :-(

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'notes.db'),
        onCreate: (db, version) => _createDb(db), version: 1);
  }
  
   static void _createDb(Database db) {
       db.execute('CREATE TABLE user_subjects(phoneNumber TEXT,serialNumber INTEGER PRIMARY KEY,isGiven INTEGER)');
       db.execute('CREATE TABLE removed_subjects(name TEXT,id INTEGER PRIMARY KEY)');
       db.execute('CREATE TABLE downloaded_subjects(path TEXT,filename TEXT,subjectname Text,id TEXT PRIMARY KEY,sem TEXT,branch TEXT,year TEXT,type TEXT)');
  }
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
  db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(String table,int id) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
  static Future<void> update(String table,Map<String, Object> data,int id) async {
    final db = await DBHelper.database();
    db.update(table,data, where: 'serialNumber = ?', whereArgs: [id]);
  }
  static Future<void> deleteDownload(String table, String path) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'path = ?', whereArgs: [path]);
  }
  // static Future<void> deleteDownloadSyllabus(String table, String ) async {
  //   final db = await DBHelper.database();
  //   db.delete(table, where: 'filename = ?', whereArgs: [filename]);
  // }
  // static Future<void> deleteDownloadQuestionPaper(String table, String filename) async {
  //   final db = await DBHelper.database();
  //   db.delete(table, where: 'filename = ?', whereArgs: [filename]);
  // }


  static Future<List<Map<String, dynamic>>> getData(String table) async {
  final db = await DBHelper.database();
  return db.query(table);
  }
  
  // static Future<int> getCount(String table) async{
  //   final db=await DBHelper.database();
  //   int count =sql.Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table')) ;
  //   return count;
  // } 
  // Future<bool> databaseExists(String path) =>
  //   databaseFactory.databaseExists(path);
}
