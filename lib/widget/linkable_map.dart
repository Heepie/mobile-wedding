import 'package:flutter/material.dart';
import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/widget/single_image.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkableMapWidget extends StatelessWidget {
  final MapContent content;

  const LinkableMapWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleImage(
          path: content.image.path,
          isRemote: content.image is! LocalImageContent,
          isWidthBigger: content.image.isWidthBigger,
          alignment: content.image.alignment,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsetsDirectional.fromSTEB(0, 12, 4, 4),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03c75a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _launchInWebView(Uri.parse(content.naverLink));
                  },
                  child: const Text(
                    "네이버 맵",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsetsDirectional.fromSTEB(4, 12, 0, 4),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFfae100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _launchInWebView(Uri.parse(content.kakaoLink));
                  },
                  child: const Text(
                    "카카오 맵",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}
