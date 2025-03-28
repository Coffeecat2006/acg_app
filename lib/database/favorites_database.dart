import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesDatabaseHelper {
  static final FavoritesDatabaseHelper instance = FavoritesDatabaseHelper._init();
  static Database? _database;

  FavoritesDatabaseHelper._init();

  Future<int> updateFavoriteTags(String id, String type, String newTags) async {
    final db = await instance.database;
    final String favKey = '${id}_$type';
    return await db.update(
      'favorites',
      {'tags': newTags},
      where: 'fav_key = ?',
      whereArgs: [favKey],
    );
  }

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
    await db.execute('''
      CREATE TABLE favorites (
        fav_key TEXT PRIMARY KEY,
        id TEXT,
        title TEXT NOT NULL,
        type TEXT NOT NULL,
        release_date TEXT,
        fav_date TEXT,
        tags TEXT,
        is_favorite INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE tags (
        tag TEXT NOT NULL PRIMARY KEY
      )
    ''');

    await db.insert('tags', {'tag': '⭐ 待觀看'});
    await db.insert('tags', {'tag': '✔️ 已觀看'});
  }

  // Favorites 表操作
  Future<int> insertFavorite(Map<String, dynamic> favorite) async {
    final db = await instance.database;
    final String favKey = '${favorite["id"]}_${favorite["type"]}';
    favorite["fav_key"] = favKey;
    favorite["is_favorite"] = 1;
    return await db.insert('favorites', favorite, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteFavorite(String id, String type) async {
    final db = await instance.database;
    final String favKey = '${id}_${type}';
    return await db.delete('favorites', where: 'fav_key = ?', whereArgs: [favKey]);
  }

  // 判斷是否已收藏 (依據 id 與 type)
  Future<bool> isFavorite(String id, String type) async {
    final db = await instance.database;
    final String favKey = '${id}_${type}';
    final res = await db.query(
      'favorites',
      where: 'fav_key = ? AND is_favorite = ?',
      whereArgs: [favKey, 1],
    );
    return res.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getAllFavorites() async {
    final db = await instance.database;
    return await db.query('favorites');
  }

  Future<List<Map<String, dynamic>>> getTags() async {
    final db = await instance.database;
    return await db.query('tags');
  }

  Future<int> insertTag(String tag) async {
    final db = await instance.database;
    return await db.insert('tags', {'tag': tag}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteTag(String tag) async {
    final db = await instance.database;
    return await db.delete('tags', where: 'tag = ?', whereArgs: [tag]);
  }

  Future<int> updateFavoriteStatus(String id, String type, int status) async {
    final db = await instance.database;
    final String favKey = '${id}_$type';
    return await db.update('favorites', {'is_favorite': status},
        where: 'fav_key = ?', whereArgs: [favKey]);
  }

  Future close() async {
    final db = await instance.database;
    return db.close();
  }
}
