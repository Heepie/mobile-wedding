import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/screen/image_viewer_screen.dart';
import 'package:mobile_wedding/screen/main_screen.dart';
import 'package:mobile_wedding/viewmodel/conversation_viewmodel.dart';

/// Application router configuration
class AppRouter {
  final ConversationViewModel viewModel;

  AppRouter({required this.viewModel});

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MainScreen(viewModel: viewModel),
      ),
      GoRoute(
        path: '/viewer',
        pageBuilder: (context, state) {
          final params = state.extra as ImageViewerParams?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ImageViewerScreen(params: params),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
    ],
  );
}

/// Parameters for image viewer screen
class ImageViewerParams {
  final int initialIndex;
  final List<MediaContent> mediaList;
  final bool enableInfiniteScroll;

  const ImageViewerParams({
    required this.initialIndex,
    required this.mediaList,
    this.enableInfiniteScroll = true,
  });
}
