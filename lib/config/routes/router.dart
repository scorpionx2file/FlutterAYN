import 'package:go_router/go_router.dart';
import 'package:traveller/video/presentation/widgets/video&articles_screen.dart';
import '../../core/constants/post/post.dart';
import '../../main.dart';
import 'app_routes.dart';

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
  ],
);

