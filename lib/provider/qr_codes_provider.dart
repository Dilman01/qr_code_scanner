import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner_app/models/qr_code_model.dart';

import 'package:sqflite/sqflite.dart' as sql;

import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, 'qr_code.db'),
    onCreate: (db, version) {
      return db
          .execute('CREATE TABLE qr_codes_db(id TEXT PRIMARY KEY, code TEXT)');
    },
    version: 1,
  );

  return db;
}

class QRCodesNotifier extends StateNotifier<List<QRCodeModel>> {
  QRCodesNotifier() : super(const []);

  Future<void> loadQRCodes() async {
    final db = await _getDatabase();
    final data = await db.query('qr_codes_db');

    final qrCodes = data
        .map(
          (e) => QRCodeModel(
            id: e['id'] as String,
            code: e['code'] as String,
          ),
        )
        .toList()
        .reversed
        .toList();

    state = qrCodes;
  }

  void removeQRCode(String id) async {
    final db = await _getDatabase();

    await db.delete(
      'qr_codes_db',
      where: 'id = ?',
      whereArgs: [id],
    );
    state = state.where((qrCode) => qrCode.id != id).toList();
  }

  void addQRCode(String code) async {
    final qrCode = QRCodeModel(code: code);

    final db = await _getDatabase();

    await db.insert('qr_codes_db', {
      'id': qrCode.id,
      'code': qrCode.code,
    });

    state = [...state, qrCode];
  }
}

final qrCodesProvider =
    StateNotifierProvider<QRCodesNotifier, List<QRCodeModel>>(
  (ref) => QRCodesNotifier(),
);
