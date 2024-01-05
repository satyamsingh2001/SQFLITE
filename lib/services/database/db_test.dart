  import 'dart:io';

  import 'package:path/path.dart';
  import 'package:sqflite/sqflite.dart';
  import 'package:users_data/screens/models/db_model.dart';

  class DbTesting {
    static const databaseName = "person.db";
    static const databaseVersion = 1;
    static const table = "usersData";

    static const id = "id";
    static const userName = "name";
    static const userImage = "UserImage";
    static const userMobile = "mobile";
    static const userEmail = "email";

    static Database? _database;

    DbTesting._privateConstructor();

    static final DbTesting instance = DbTesting._privateConstructor();

    Future<Database?> get database async {
      if (_database != null) {
        return _database;
      }
      _database = await _initDB("person.db");
      return _database;
    }

    Future<Database> _initDB(String filePath) async {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(path,
          version: databaseVersion, onCreate: _createDB);
    }

    Future _createDB(Database db, int version) async {
      await db.execute('''
      CREATE TABLE $table(
        $id INTEGER PRIMARY KEY,
        $userImage TEXT ,
        $userName TEXT ,
        $userMobile TEXT ,
        $userEmail TEXT 
      )
      ''');
    }

    // functon  for insert

    Future<int?> addDetails(StoreData storeData) async {
      Database? db = await instance.database;
      return await db?.insert(table, storeData.toMap());
    }

    //function for show all data

    Future<List<Map<String, Object?>>?> getAllData() async{
      Database? db = await instance.database;
      return await db?.query(table);
  }

    Future<int?> removeData(int id) async {
      final db = await instance.database;
      return await db?.delete(
        'usersData',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

  }

  void removeProduct(int id) async {
    final result = await DbTesting.instance.removeData(id);
    print('Product removed with ID: $id, Result: $result');
  }

  void addDataToDatabase(final File? imageUrl, final String name,
      final String mobile, final String email) async {
    final userData = StoreData(
      imageUrl: imageUrl,
      name: name,
      mobile: mobile,
      email: email,
    );

    // Convert File to String (file path)
    String? imagePath = imageUrl?.path;

    // Modify the StoreData object before inserting into the database
    final result = await DbTesting.instance.addDetails(userData);
    print('Product added with ID: $result');
  }







