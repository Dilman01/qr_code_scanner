import 'package:uuid/uuid.dart';

const uuid = Uuid();

class QRCodeModel {
  QRCodeModel({
    required this.code,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String code;
}
