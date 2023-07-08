import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner_app/models/qr_code_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/qr_code_bloc.dart';

class QRCodeList extends StatelessWidget {
  const QRCodeList(this.qrCodes, {super.key});

  final List<QRCode> qrCodes;

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

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: qrCodes.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          _launchURL(qrCodes[index].code);
        },
        child: Card(
          elevation: 5,
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
                const Icon(
                  Icons.qr_code_2_rounded,
                  size: 35,
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    qrCodes[index].code,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: qrCodes[index].code));
                  },
                  icon: const Icon(
                    Icons.copy,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<QRCodeBloc>()
                        .add(DeleteQRCode(qrCode: qrCodes[index]));
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
