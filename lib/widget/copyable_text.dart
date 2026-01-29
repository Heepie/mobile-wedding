import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wedding/model/content.dart';

class CopyableTextWidget extends StatelessWidget {
  final CopyableTextListContent content;

  const CopyableTextWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (content.title.isNotEmpty) ...[
          Text(content.title),
          const SizedBox(height: 4),
        ],
        ...content.copyableTextList
            .map((copyableText) => _getContainerWidget(context, copyableText)),
      ],
    );
  }

  Widget _getContainerWidget(
    BuildContext context,
    CopyableTextContent copyableText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          copyableText.description,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...copyableText.copyableTextList.map(
          (text) => Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 1),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                minimumSize: const Size(260, 40),
              ),
              onPressed: () {
                Clipboard.setData(
                    ClipboardData(text: text.substring(0, text.indexOf(" ("))));
                const snackBar = SnackBar(
                  content: Text('복사가 완료되었습니다.'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                text,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
