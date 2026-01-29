import 'package:flutter/material.dart';

import 'model/content.dart';
import 'model/conversation.dart';
import 'model/user.dart';

void main() {
  // Model layer test
  final content = TextContent(text: 'Hello');
  final message = Message(from: User.me, to: User.you, content: content);
  final conversation = message.addDelay(1000);
  debugPrint('Conversation delay: ${conversation.delayMs}ms');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Mobile Wedding'),
        ),
      ),
    );
  }
}
