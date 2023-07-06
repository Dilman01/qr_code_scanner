import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sqflite/sqflite.dart' as sql;

import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, 'qrCodes.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE qr_codes(code TEXT)');
    },
    version: 1,
  );

  return db;
}

class QRCodesNotifier extends StateNotifier<List<String>> {
  QRCodesNotifier() : super(const []);

  Future<void> loadQRCodes() async {
    final db = await _getDatabase();
    final data = await db.query('qr_codes');

    final qrCodes = data
        .map(
          (e) => e['code'] as String,
        )
        .toList();

    state = qrCodes;
  }

  void removeCode(String code) async {
    final db = await _getDatabase();

    await db.delete(
      'qr_codes',
      where: 'code = ?',
      whereArgs: [code],
    );
    
  }

  void addQRCode(String code) async {
    final db = await _getDatabase();

    await db.insert('qr_codes', {
      'code': code,
    });

    state = [code, ...state];
  }
}

final qrCodesProvider = StateNotifierProvider<QRCodesNotifier, List<String>>(
  (ref) => QRCodesNotifier(),
);
