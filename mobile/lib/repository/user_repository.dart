import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobile/model/user_model.dart';

class UserRepository {
  Database? _database;
  final String baseUrl = "http://localhost:8000/api";
  Client client = Client();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Users(id TEXT PRIMARY KEY, name TEXT, email TEXT, token TEXT)',
        );
      },
    );
  }

  Future<User> authenticate(String email, String password,
      {String name = "", bool isLogin = true}) async {
    var url = Uri.parse('$baseUrl/${isLogin ? "login" : "register"}');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var payload = jsonEncode(isLogin
        ? {'email': email, 'password': password}
        : {'name': name, 'email': email, 'password': password});
    final response = await client.post(url, headers: headers, body: payload);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      User user = User.fromJson(json);
      await saveUserToDatabase(user);
      return user;
    } else {
      throw Exception('Failed to authenticate!');
    }
  }

  Future<void> saveUserToDatabase(User user) async {
    final db = await database;
    await db.insert('Users', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User?> getUserFromDatabase() async {
    final db = await database;
    List<Map> maps = await db.query('Users', limit: 1);
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    }
    return null;
  }

  Future<void> clearUser() async {
    final db = await database;
    await db.delete('Users');
  }

  Future<User?> getLoggedInUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Users');
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    }
    return null;
  }
}
