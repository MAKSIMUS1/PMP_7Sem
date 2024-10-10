import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/film_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  String? _dbPath;

  void setDatabasePath(String path) {
    _dbPath = path;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = _dbPath ?? join(await getDatabasesPath(), 'films.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''        
          CREATE TABLE films(
            id INTEGER PRIMARY KEY,
            title TEXT,
            director TEXT,
            releaseYear INTEGER,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertFilm(Film film) async {
    final db = await database;
    await db.insert('films', film.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Film>> getFilms() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('films');

    return List.generate(maps.length, (i) {
      return Film(
        id: maps[i]['id'],
        title: maps[i]['title'],
        director: maps[i]['director'],
        releaseYear: maps[i]['releaseYear'],
        description: maps[i]['description'],
      );
    });
  }

  Future<void> updateFilm(Film film) async {
    final db = await database;
    await db.update(
      'films',
      film.toJson(),
      where: 'id = ?',
      whereArgs: [film.id],
    );
  }

  Future<void> deleteFilm(int id) async {
    final db = await database;
    await db.delete(
      'films',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
