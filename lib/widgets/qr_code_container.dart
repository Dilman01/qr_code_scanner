// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class QRCodeContainer extends StatelessWidget {
  const QRCodeContainer(this.qrCodes, this.remove, {super.key});

  final List<String> qrCodes;
  final Function(String code) remove;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    // final qrCodes = ref.read(qrCodesProvider);

    return ListView.separated(
      itemCount: qrCodes.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          _launchURL(qrCodes[index]);
        },
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
                  qrCodes[index],
                  style: TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: qrCodes[index]));
                },
                icon: Icon(
                  Icons.copy,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  remove(qrCodes[index]);
                },
                icon: Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
