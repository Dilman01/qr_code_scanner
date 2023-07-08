import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner_app/bloc/qr_code_bloc.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_container.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_view.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
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
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.orange,
                      size: 40,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Scanning History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<QRCodeBloc, QRCodesState>(
                      builder: (context, state) {
                        if (state.qrCodes.isNotEmpty) {
                          return QRCodeContainer(
                            state.qrCodes.reversed.toList(),
                          );
                        } else if (state is QRCodesInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const Center(
                          child: Text('Nothing here.'),
                        );
                      },
                    ),
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
