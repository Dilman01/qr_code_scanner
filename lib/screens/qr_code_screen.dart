import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner_app/provider/qr_codes_provider.dart';
import 'package:qr_code_scanner_app/screens/history_screen.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_view.dart';

class QRCodeScreen extends ConsumerStatefulWidget {
  const QRCodeScreen({
    super.key,
    required this.code,
  });

  final String code;

  @override
  ConsumerState<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends ConsumerState<QRCodeScreen> {
  @override
  void initState() {
    controller!.pauseCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final qrCodes = ref.read(qrCodesProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Result:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.code.trim(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextButton(
                onPressed: () {
                  qrCodes.addQRCode(widget.code);
                  controller!.pauseCamera();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) {
                        // controller!.pauseCamera();
                        return const HistoryScreen();
                      },
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                  foregroundColor: Colors.orange.shade50,
                ),
                child: const Text('Save'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.orange.shade600,
                ),
              ),
              child: TextButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.code));
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.orange.shade600,
                ),
                icon: const Icon(Icons.copy),
                label: const Text('Copy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
