// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner_app/screens/qr_code_screen.dart';

QRViewController? controller;

class QRCodeView extends StatefulWidget {
  const QRCodeView({super.key});

  @override
  State<QRCodeView> createState() => _QRCodeViewState();
}

class _QRCodeViewState extends State<QRCodeView> {
  final qrKey = GlobalKey();

  String? code;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void onQRViewCreated(QRViewController control) async {
    setState(() {
      controller = control;
    });

    controller!.scannedDataStream.listen(
      (barcode) async {
        setState(() {
          code = barcode.code;
        });

        if (code != null) {
          await controller!.pauseCamera();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeScreen(
                code: code!,
              ),
            ),
          ).then(
            (_) => controller!.resumeCamera(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(20),
      child: QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderColor: Colors.deepOrangeAccent,
        ),
      ),
    );
  }
}
