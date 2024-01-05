import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:users_data/screens/models/db_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE your_table (
            id INTEGER PRIMARY KEY,
            image TEXT,
            name TEXT,
            mobile TEXT,
            address TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertData({
    required String image,
    required String name,
    required String mobile,
    required String address,
  }) async {
    final db = await database;
    await db.insert(
      'your_table',
      {
        'image': image,
        'name': name,
        'mobile': mobile,
        'address': address,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await database;
    return await db.query('your_table');
  }






}
