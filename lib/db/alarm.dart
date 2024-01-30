import 'package:bacteriofago/db/medicine.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AlarmSchema {
  AlarmSchema({this.id = 0, required this.medicine, required this.time});

  int id;
  int medicine;
  String time;

  Map<String, dynamic> toMap({bool noId = true}) {
    var map = {
      'medicine': medicine,
      'time': time
    };
    if(noId) return map;
    map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'Alarm {id: $id, medicineID: $medicine, time: $time}';
  }
}

class Alarm {
  static Future<Database> initDB() async {
    // Depends for foreign key
    Medicine.initDB();
    return openDatabase(join(await getDatabasesPath(), 'bacteriofago.db'),
        onCreate: (db, version) async {
      await db.execute('CREATE TABLE alarm('
          'id INTEGER PRIMARY KEY ASC , '
          'medicine INT'
          'time TEXT'
          'FOREIGN KEY (medicine) REFERENCES medicine(id)'
          ')');
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await initDB();
    return db.query('alarm', orderBy: 'id');
  }

  static Future<void> insertAlarm(AlarmSchema alarm) async {
    final db = await initDB();
    await db.insert('alarm', alarm.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateAlarm(int id, AlarmSchema alarm) async {
    final db = await initDB();
    final result = await db
        .update('alarm', alarm.toMap(), where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteAlarm(int id) async {
    final db = await initDB();
    try {
     await db.delete('alarm', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Error deleting alarm: $err');
    }
  }
}


