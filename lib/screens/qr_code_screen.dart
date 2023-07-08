import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner_app/bloc/qr_code_bloc.dart';
import 'package:qr_code_scanner_app/models/qr_code_model.dart';
import 'package:qr_code_scanner_app/screens/history_screen.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_view.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({
    super.key,
    required this.code,
  });

  final QRCode code;

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller!.resumeCamera();
        return true;
      },
      child: Scaffold(
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
                widget.code.code.trim(),
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
                    context
                        .read<QRCodeBloc>()
                        .add(AddQRCode(qrCode: widget.code));

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) {
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
                    Clipboard.setData(ClipboardData(text: widget.code.code));
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
      ),
    );
  }
}
