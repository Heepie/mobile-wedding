import 'package:flutter/material.dart';
import 'package:mobile_wedding/config/wedding_config.dart';

class Announcement extends StatelessWidget {
  final VoidCallback onShowImmediately;

  const Announcement({super.key, required this.onShowImmediately});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: Image.asset(
            WeddingConfig.introImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${WeddingConfig.groomName} ${WeddingConfig.brideName} 결혼해요!',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          WeddingConfig.announcementDateVenue,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: onShowImmediately,
          child: const Text('전체 내용 바로 보기'),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
