// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 700,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Scan QR Code'),
                Text('Place qr code inside the frame'),
                SizedBox(
                  height: 35,
                ),
                // Image.asset('assets/images/qr_code1.jpg'),
                QRCodeView(),
                SizedBox(
                  height: 30,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.photo),
                //     Icon(Icons.keyboard),
                //     Icon(Icons.flash_on),
                //   ],
                // ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 250,
                  height: 50,
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
                // SizedBox(
                //   width: 200,
                //   height: 50,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.orange,
                //     ),
                //     child: const Text('Place Camera Code'),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
