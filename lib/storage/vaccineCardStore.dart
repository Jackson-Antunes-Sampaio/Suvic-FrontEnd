import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

String tableCard = "card";
String columnId = "id";
String columnName = "name";
String columnApplicationDate = "applicationDate";

class VaccineCardStore {
  late Database db;
  int? id;
  String? name;
  String? applicationDate;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnApplicationDate: applicationDate,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // construtor
  VaccineCardStore();

  VaccineCardStore.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    applicationDate = map[applicationDate!];
  }

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableCard( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnApplicationDate text not null)
''');
    });
  }

  Future<VaccineCardStore> insert(VaccineCardStore vcs) async {
    vcs.id = await db.insert(tableCard, vcs.toMap());
    return vcs;
  }

  Future<VaccineCardStore?> getTodo(int id) async {
    List<Map> maps = await db.query(tableCard,
        columns: [columnId, columnName, columnApplicationDate],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return VaccineCardStore.fromMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }
}
