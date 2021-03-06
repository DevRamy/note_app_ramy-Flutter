import 'package:note_app_ramy/Database/helper_methods.dart';
import 'package:note_app_ramy/Database/note_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  // ignore: non_constant_identifier_names
  static String DatabaseName = 'noteApp.db';

  Future<Database> get database async {
    if (_database != null) return _database!;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  static const tableNote = """
  CREATE TABLE IF NOT EXISTS Note (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dateTime TEXT,
        title TEXT,
        noteBody TEXT
      );""";

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), DatabaseName);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(tableNote);
    });
  }

  Future<void> createNote(Note note) async {
    final db = await database;

    await db.insert('Note', note.toJson());
  }

  Future<void> updateNote(int id, Note note) async {
    final db = await database;

    await db.update(
      'Note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await database;

    await db.delete(
      'Note',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// get all note
  Future<void> getAllNote() async {
    // ignore: avoid_print
    print('getAllNote executed');
    final db = await database;
    var res = await db.query("Note");

    allNote = [];

    // ignore: avoid_function_literals_in_foreach_calls
    res.forEach((element) {
      allNote.add(Note.fromJson(element));
    });
  }
}
