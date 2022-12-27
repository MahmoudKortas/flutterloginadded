import 'package:new1/models/post.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../../models/user.dart';

class DbHelper {
  static Database? _db;
  static const String dbName = 'tesssst.db';
  static const String tableName = 'user';
  static const String table2Name = 'post';
  static const int version = 1;

  static const String id = 'id';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    Future.wait([
      db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)'),
      db.execute(
          'CREATE TABLE $table2Name (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, image TEXT, avatar TEXT, name TEXT, isLike INTEGER, isFile INTEGER)')
    ]);
  }

  Future<int> saveData(UserModel user) async {
    final dbClient = await db;
    final res = await dbClient.insert(tableName, user.toMap());
    return res;
  }

  Future<int> savePost(Post post) async {
    final dbClient = await db;
    final res = await dbClient.insert(table2Name, post.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String email, String password) async {
    final dbClient = await db;
    final List list = await dbClient.rawQuery("SELECT * FROM $tableName WHERE "
        "email = '$email' AND "
        "password = '$password'");
    if (list.isEmpty) {
      return null;
    }
    return UserModel.fromMap(list.first);
  }

  Future<Post?> getPost(int id) async {
    final dbClient = await db;
    final List list = await dbClient.rawQuery("SELECT * FROM $table2Name WHERE "
        "id = '$id' ");
    if (list.isEmpty) {
      return null;
    }
    return Post.fromMap(list.first);
  }

  Future<List<Post?>?> getPosts() async {
    final dbClient = await db;
    final List list = await dbClient.rawQuery("SELECT * FROM $table2Name ");
    if (list.isEmpty) {
      return null;
    }
    return list.map((e) => Post.fromJson(e)).toList();
  }

  Future<int> deleteUser(String userID) async {
    var dbClient = await db;
    var res =
        await dbClient.delete(tableName, where: '$id = ?', whereArgs: [userID]);
    return res;
  }
}
