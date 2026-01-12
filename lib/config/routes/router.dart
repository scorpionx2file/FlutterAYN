import 'package:go_router/go_router.dart';
import 'package:traveller/video/presentation/widgets/video&articles_screen.dart';
import '../../core/constants/post/post.dart';
import '../../core/utils/post_utils.dart';
import '../../main.dart';
import 'app_routes.dart';
import 'package:flutter/material.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.Home,
  routes: [
    GoRoute(
      path: AppRoutes.Home,
      builder: (context, state) => const HomeRoot(),
    ),
    GoRoute(
      path: AppRoutes.Video,
      builder: (context, state)  {
        final postData = state.extra as PostData;
        return VideoAndArticlesScreen(postData: postData);
      },
    ),
    GoRoute(
      path: '/post/:id', // <-- deep link route
      builder: (context, state) {
        final postId = state.pathParameters['id']!;
        final post = findPostById(postId);

        if (post == null) {
          return const Scaffold(
            body: Center(child: Text('Post not found')),
          );
        }

        return VideoAndArticlesScreen(postData: post);
      },
    ),
  ],
);

