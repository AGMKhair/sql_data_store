import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqlFinWix;
import 'package:sqflite/sqflite.dart';
import 'package:sql_data_store/credit_manage.dart';

class SQLHelperFinWix {
  static Future<sqlFinWix.Database> db() async {
    return sqlFinWix.openDatabase(
      'finwix.db',
      version: 1,
      onCreate: (sqlFinWix.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create Table
  static Future<void> createTables(sqlFinWix.Database database) async {
    await database.execute("""CREATE TABLE credit_manage(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        type TEXT,
        category TEXT,
        details TEXT,
        amount DOUBLE,
        date TEXT,
        time TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  // Read all items (journals)
  static Future<List<CreditManage>> getAllCreditItem() async {
    final db = await SQLHelperFinWix.db();
    final List<Map<String, Object?>> queryResult = await db.query('credit_manage', orderBy: "id");
    return queryResult.map((e) => CreditManage.fromMap(e)).toList();
  }

  // Read single data
  static Future<List<Map<String, dynamic>>> getCreditItem(int id) async {
    final db = await SQLHelperFinWix.db();
    return db.query('credit_manage', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Create new item (journal)
  static Future<int> createCreditItem(CreditManage creditManage) async {
    final db = await SQLHelperFinWix.db();

    final data = {'type': creditManage.type, 'category': creditManage.category, 'details': creditManage.details, 'amount': creditManage.amount, 'date': creditManage.date, 'time': creditManage.time};
    final id = await db.insert('credit_manage', data, conflictAlgorithm: sqlFinWix.ConflictAlgorithm.replace);
    return id;
  }

  // insert data
  Future<int> insertItems(List<CreditManage> items) async {
    int result = 0;
    final db = await SQLHelperFinWix.db();
    for (var item in items) {
      result = await db.insert('credit_manage', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return result;
  }

  // Retrieve data
  Future<List<CreditManage>> retrieveItems() async {
    final db = await SQLHelperFinWix.db();
    final List<Map<String, Object?>> queryResult = await db.query('credit_manage');
    return queryResult.map((e) => CreditManage.fromMap(e)).toList();
  }

  // Update Data
  static Future<int> updateCreditItem(CreditManage creditManage) async {
    final db = await SQLHelperFinWix.db();

    final data = {'type': creditManage.type, 'category': creditManage.category, 'details': creditManage.details, 'amount': creditManage.amount, 'date': creditManage.date, 'time': creditManage.time};
    final id = await db.update(
      'credit_manage',
      data,
      where: "id = ?",
      whereArgs: [creditManage.id],
    );
    return id;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperFinWix.db();
    try {
      await db.delete("credit_manage", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
