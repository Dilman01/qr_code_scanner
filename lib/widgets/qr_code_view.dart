// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner_app/models/qr_code_model.dart';
import 'package:qr_code_scanner_app/widgets/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/qr_code_bloc.dart';

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

  bool canLaunch = false;

  Future<void> launch(String url) async {
    final uri = Uri.parse(url);
    final launch = await canLaunchUrl(uri);

    setState(() {
      canLaunch = launch;
    });
  }

  void onQRViewCreated(QRViewController con) async {
    setState(() {
      controller = con;
    });

    controller!.scannedDataStream.listen(
      (barcode) async {
        code = barcode.code;

        if (code != null) {
          launch(code!);
          await controller!.stopCamera();

          context
              .read<QRCodeBloc>()
              .add(AddQRCode(qrCode: QRCode(code: code!)));

          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              code: code,
              canLaunch: canLaunch,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 450,
          padding: const EdgeInsets.all(5),
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
        const SizedBox(
          height: 20,
        ),
        Row(
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
      ],
    );
  }
}
