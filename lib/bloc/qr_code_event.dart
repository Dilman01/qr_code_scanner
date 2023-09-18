part of 'qr_code_bloc.dart';

abstract class QRCodeEvent {}

class AddQRCode extends QRCodeEvent {
  final QRCode qrCode;

  AddQRCode({required this.qrCode});
}

class LoadedQRCodes extends QRCodeEvent {}

class DeletedQRCode extends QRCodeEvent {
  final QRCode qrCode;

  DeletedQRCode({required this.qrCode});
}
