import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesDatabaseHelper {
  static final FavoritesDatabaseHelper instance = FavoritesDatabaseHelper._init();
  static Database? _database;

  FavoritesDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE favorites (
        id $idType,
        title $textType,
        type $textType
      )
    ''');
  }

  Future<int> insertFavorite(Map<String, dynamic> favorite) async {
    final db = await instance.database;
    return await db.insert('favorites', favorite, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteFavorite(String id) async {
    final db = await instance.database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllFavorites() async {
    final db = await instance.database;
    return await db.query('favorites');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
