part of 'qr_code_bloc.dart';

abstract class QRCodesState {
  List<QRCode> qrCodes;

  QRCodesState({required this.qrCodes});
}

class QRCodesInitial extends QRCodesState {
  QRCodesInitial({required List<QRCode> qrCodes}) : super(qrCodes: qrCodes);
}

class QRCodesLoad extends QRCodesState {
  QRCodesLoad({required List<QRCode> qrCodes}) : super(qrCodes: qrCodes);
}
