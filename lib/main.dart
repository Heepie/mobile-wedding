import 'package:flutter/material.dart';

import 'repository/local_datasource.dart';
import 'repository/repository.dart';
import 'repository/repository_impl.dart';

void main() {
  // Repository layer test
  final Repository repository = RepositoryImpl(LocalDataSource());
  final conversations = repository.getAllConversations();
  debugPrint('Loaded ${conversations.length} conversations');

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
