import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner_app/widgets/qr_code_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    required this.code,
    required this.canLaunch,
  });

  final String? code;
  final bool canLaunch;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
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
    // launch(widget.code!);
    return WillPopScope(
      onWillPop: () async {
        controller!.resumeCamera();
        return true;
      },
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'RESULT',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 220,
                    // padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.code!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.code!));
                    },
                    icon: const Icon(
                      Icons.copy,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      controller!.resumeCamera();
                      Navigator.of(context).pop();
                    },
                    clipBehavior: Clip.antiAlias,
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.orange.shade600,
                        fixedSize: const Size(120, 50),
                        side: const BorderSide(color: Colors.orange)),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: widget.canLaunch
                        ? () => _launchURL(widget.code!)
                        : null,
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 50),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      // enableFeedback: false,
                    ),
                    child: const Text('Open'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
