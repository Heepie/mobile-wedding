import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDivider extends StatelessWidget {
  const DateDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatted = DateFormat('yy.MM.dd (EE) h:mm a', 'ko_KR').format(now);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              formatted,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
