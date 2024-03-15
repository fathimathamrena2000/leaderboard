import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/usermodel.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'leaderboard.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE leaders(
            userId TEXT PRIMARY KEY,
            name TEXT,
            profilePic TEXT,
            points INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> insertLeaders(List<Leader> leaders) async {
    final Database db = await database;
    Batch batch = db.batch();
    leaders.forEach((leader) {
      batch.insert('leaders', leader.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    await batch.commit();
  }

  static Future<List<Leader>> getLeaders() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('leaders', orderBy: 'points DESC');
    return List.generate(maps.length, (i) {
      return Leader(
        userId: maps[i]['userId'],
        name: maps[i]['name'],
        profilePic: maps[i]['profilePic'],
        points: maps[i]['points'],
      );
    });
  }
}
