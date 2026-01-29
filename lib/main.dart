import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_wedding/repository/local_datasource.dart';
import 'package:mobile_wedding/config/wedding_config.dart';
import 'package:mobile_wedding/util/const.dart';
import 'package:mobile_wedding/repository/repository_impl.dart';
import 'package:mobile_wedding/router/app_router.dart';
import 'package:mobile_wedding/viewmodel/conversation_viewmodel.dart';

void main() {
  initializeDateFormatting('ko_KR');
  runApp(const MyApp());
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create dependencies
    final localDataSource = LocalDataSource();
    final repository = RepositoryImpl(localDataSource);
    final viewModel = ConversationViewModel(repository);
    final appRouter = AppRouter(viewModel: viewModel);

    return MaterialApp.router(
      title: WeddingConfig.appTitle,
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        colorSchemeSeed: backgroundColor,
      ),
      routerConfig: appRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
