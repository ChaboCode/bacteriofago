import 'package:bacteriofago/schemas.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DB {
  static Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(join(await getDatabasesPath(), 'bacteriofago.db'),
        onCreate: (db, version) async {
      await db.execute('CREATE TABLE medicine('
          'id INTEGER PRIMARY KEY ASC , '
          'name TEXT, '
          'actives TEXT, '
          'dose INT, '
          'doseUnit TEXT'
          ')');
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await initDB();
    return db.query('medicine', orderBy: 'id');
  }

  static Future<void> insertMedicine(Medicine medicine) async {
    final db = await initDB();
    await db.insert('medicine', medicine.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateMedicine(int id, Medicine medicine) async {
    final db = await initDB();
    final result = await db
        .update('medicine', medicine.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteMedicine(int id) async {
    final db = await initDB();
    try {
     await db.delete('medicine', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Error deleting medicine: $err");
    }
  }
}
