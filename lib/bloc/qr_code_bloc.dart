import 'package:bloc/bloc.dart';
import 'package:qr_code_scanner_app/models/qr_code_model.dart';

import '../database/sql_helper.dart';

part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QRCodeBloc extends Bloc<QRCodeEvent, QRCodesState> {
  QRCodeBloc() : super(QRCodesInitial(qrCodes: [])) {
    on<AddQRCode>(_addQRCode);
    on<DeletedQRCode>(_deleteQRCode);
    on<LoadedQRCodes>(_loadQRCodes);
  }
  late final List<QRCode> qrCoodesList;

  SQLHelper sql = SQLHelper();

  void _addQRCode(AddQRCode event, Emitter<QRCodesState> emit) {
    state.qrCodes.add(event.qrCode);
    sql.createQRCode(event.qrCode.code, event.qrCode.id);
    emit(QRCodesLoad(qrCodes: state.qrCodes.toList()));
  }

  void _loadQRCodes(LoadedQRCodes event, Emitter<QRCodesState> emit) async {
    qrCoodesList = await sql.getQRCodes();

    emit(QRCodesLoad(qrCodes: qrCoodesList.reversed.toList()));
  }

  void _deleteQRCode(DeletedQRCode event, Emitter<QRCodesState> emit) {
    state.qrCodes.remove(event.qrCode);
    sql.deleteQRCode(event.qrCode.id);
    emit(QRCodesLoad(qrCodes: state.qrCodes.toList()));
  }
}
