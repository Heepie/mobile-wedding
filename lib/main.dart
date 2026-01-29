import 'package:flutter/material.dart';

import 'model/content.dart';
import 'model/user.dart';

void main() {
  // Model layer test
  const user = User.me;
  final content = TextContent(text: 'Hello');
  debugPrint('User: $user, Content: $content');

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
