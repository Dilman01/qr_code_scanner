part of 'qr_code_bloc.dart';

abstract class QRCodeEvent {}

class AddQRCode extends QRCodeEvent {
  final QRCode qrCode;

  AddQRCode({required this.qrCode});
}

class LoadQRCodes extends QRCodeEvent {}

class DeleteQRCode extends QRCodeEvent {
  final QRCode qrCode;

  DeleteQRCode({required this.qrCode});
}
