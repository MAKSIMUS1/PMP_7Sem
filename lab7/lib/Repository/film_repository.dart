import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/film_model.dart';

class FilmRepository {
  Database? _database;
  String? _databasePath;

  void setDatabasePath(String path) {
    _databasePath = path;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = _databasePath ?? await getDatabasesPath();
    return openDatabase(
      join(path, 'films.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE films(id INTEGER PRIMARY KEY, title TEXT, director TEXT, releaseYear INTEGER, description TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<Film>> getAllFilms() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('films');
    return List.generate(maps.length, (i) {
      return Film.fromJson(maps[i]);
    });
  }

  Future<void> addFilm(Film film) async {
    final db = await database;
    await db.insert('films', film.toJson());
  }

  Future<void> updateFilm(Film film) async {
    final db = await database;
    await db.update('films', film.toJson(), where: 'id = ?', whereArgs: [film.id]);
  }

  Future<void> deleteFilm(int id) async {
    final db = await database;
    await db.delete('films', where: 'id = ?', whereArgs: [id]);
  }
}
