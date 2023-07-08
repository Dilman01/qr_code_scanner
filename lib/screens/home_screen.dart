import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/screens/history_screen.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                    controller!.pauseCamera();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.history,
                    color: Colors.orange,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Scan QR Code',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const QRCodeView(),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    width: 250,
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Place the camera on the qr code',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
