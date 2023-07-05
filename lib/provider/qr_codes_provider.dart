import 'package:flutter_riverpod/flutter_riverpod.dart';

class QRCodesNotifier extends StateNotifier<List<String>> {
  QRCodesNotifier() : super(const []);

  void addQRCode(String code) {
    state = [code, ...state];
  }
}

final qrCodesProvider = StateNotifierProvider<QRCodesNotifier, List<String>>(
  (ref) => QRCodesNotifier(),
);
