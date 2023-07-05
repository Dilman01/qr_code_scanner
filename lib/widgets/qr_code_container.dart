// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_app/data/qr_code_list.dart';

class QRCodeContainer extends StatefulWidget {
  const QRCodeContainer(this.code, {super.key});

  final String code;

  @override
  State<QRCodeContainer> createState() => _QRCodeContainerState();
}

class _QRCodeContainerState extends State<QRCodeContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.qr_code_2_rounded,
              size: 35,
            ),
            SizedBox(
              width: 150,
              child: Text(
                widget.code,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.copy,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  qrCodes.remove(widget.code);
                });
              },
              icon: Icon(
                Icons.delete,
                size: 20,
              ),
            ),
          ],
        ),
        // child: ListTile(
        //   leading: Icon(
        //     Icons.qr_code_2_rounded,
        //     size: 35,
        //   ),
        //   title: Text('QR Code Result Here'),
        //   trailing: Container(
        //     width: 100,

        //     child: Row(
        //       mainAxisSize: MainAxisSize.max,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
