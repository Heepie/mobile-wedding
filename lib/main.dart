import 'package:flutter/material.dart';

import 'repository/local_datasource.dart';
import 'repository/repository_impl.dart';
import 'viewmodel/conversation_viewmodel.dart';

void main() {
  // ViewModel layer test
  final repository = RepositoryImpl(LocalDataSource());
  final viewModel = ConversationViewModel(repository);
  debugPrint('ViewModel created, showAll: ${viewModel.showAllImmediately}');

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
