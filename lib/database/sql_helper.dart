import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/qr_code_model.dart';

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database
        .execute('CREATE TABLE qr_codes(id TEXT PRIMARY KEY, code TEXT)');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'qr_codes_list.db',
      version: 1,
      onCreate: (db, version) async {
        await createTable(db);
      },
    );
  }

  Future<int> createQRCode(String code, String id) async {
    final db = await SQLHelper.db();

    final data = {'code': code, 'id': id};

    final rowID = await db.insert(
      'qr_codes',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return rowID;
  }

  Future<List<QRCode>> getQRCodes() async {
    final db = await SQLHelper.db();

    final list = await db.query('qr_codes');

    final qrCodes = list
        .map(
          (e) => QRCode(
            id: e['id'] as String,
            code: e['code'] as String,
          ),
        )
        .toList()
        .reversed
        .toList();

    return qrCodes;
  }

  Future<void> deleteQRCode(String id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete('qr_codes', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint('Something went wrong when deleting a QR Code: $e');
    }
  }
}
