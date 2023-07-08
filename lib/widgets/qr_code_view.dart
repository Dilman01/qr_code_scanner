import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner_app/models/qr_code_model.dart';
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
        code = barcode.code;

        if (code != null) {
          await controller!.stopCamera();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeScreen(
                code: QRCode(code: code!),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await controller!.flipCamera();
                  },
                  icon: const Icon(
                    Icons.flip_camera_ios_outlined,
                    color: Colors.orange,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () async {
                    await controller!.toggleFlash();
                  },
                  icon: const Icon(
                    Icons.flash_on_outlined,
                    color: Colors.orange,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
