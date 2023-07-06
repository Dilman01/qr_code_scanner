// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner_app/provider/qr_codes_provider.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_container.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_view.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  late Future<void> _qrCodesFuture;

  @override
  void initState() {
    super.initState();

    _qrCodesFuture = ref.read(qrCodesProvider.notifier).loadQRCodes();
  }

  void remove(String code) {
    final qrCodes = ref.watch(qrCodesProvider.notifier);

    setState(() {
      qrCodes.removeCode(code);
      _qrCodesFuture = ref.read(qrCodesProvider.notifier).loadQRCodes();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      controller!.pauseCamera();
    });
    final qrCodes = ref.watch(qrCodesProvider);

    return WillPopScope(
      onWillPop: () async {
        controller!.resumeCamera();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 700,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      controller!.resumeCamera();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.orange,
                      size: 35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: const Text(
                        'Searching History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: _qrCodesFuture,
                      builder: (context, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : QRCodeContainer(qrCodes, remove),
                    ),
                    // child: ListView.separated(
                    //   itemCount: qrCodes.length,
                    //   separatorBuilder: (context, index) => SizedBox(
                    //     height: 20,
                    //   ),
                    //   itemBuilder: (context, index) =>
                    //       QRCodeContainer(qrCodes[index], remove),
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
