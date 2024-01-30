import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MedicineSchema {
  MedicineSchema(
      {this.id = 0,
      required this.name,
      required this.actives,
      required this.dose,
      required this.doseUnit});

  int id;
  String name;
  List<String> actives;
  int dose;
  String doseUnit;

  Map<String, dynamic> toMap({bool noId = true}) {
    var map = {
      'name': name,
      'actives': actives.join(' '),
      'dose': dose,
      'doseUnit': doseUnit
    };
    if(noId) return map;
    map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'Medicine {id: $id, name: $name, actives: $actives, '
        'dose: $dose, doseUnit: $doseUnit}';
  }
}

class Medicine {
  static Future<Database> initDB() async {
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

  static Future<List<Map<String, dynamic>>> findByName(String name) async {
    final db = await initDB();
    return db.query('medicine', where: 'name LIKE %$name%');
  }

  static Future<void> insertMedicine(MedicineSchema medicine) async {
    final db = await initDB();
    await db.insert('medicine', medicine.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateMedicine(int id, MedicineSchema medicine) async {
    final db = await initDB();
    final result = await db
        .update('medicine', medicine.toMap(), where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteMedicine(int id) async {
    final db = await initDB();
    try {
     await db.delete('medicine', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Error deleting medicine: $err');
    }
  }
}

