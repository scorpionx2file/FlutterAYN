import 'package:go_router/go_router.dart';
import 'package:traveller/auth/presentation/screen/choose_gates_screen.dart';
import 'package:traveller/auth/presentation/screen/forget_password_screen.dart';
import 'package:traveller/auth/presentation/screen/sign_in_screen.dart';
import 'package:traveller/auth/presentation/screen/sign_up_screen.dart';
import 'package:traveller/gates/presentation/widgets/gates_screen.dart';
import 'package:traveller/home/presentation/widgets/home_screen.dart';
import 'package:traveller/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:traveller/otp/presentation/screen/otp_screen.dart';
import 'package:traveller/splash_screen.dart';
import 'package:traveller/video/presentation/widgets/video&articles_screen.dart';
import '../../core/constants/activity_card/activity_card.dart';
import '../../core/constants/gate/app_gate_card.dart';
import '../../core/constants/post/post.dart';
import '../../core/constants/post/post_content/post_content.dart';
import '../../core/constants/post_service_provider_header/post_or_service_provider_header.dart';
import '../../core/constants/story_item/story_item.dart';
import '../../core/utils/post_utils.dart';
import '../../main.dart';
import 'app_routes.dart';
import 'package:flutter/material.dart';

final badgeData = AppGateBadgeData(
  icon: Icons.sunny,
  primaryText: "25",
  secondaryText: "18",
);
final gates = [
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
  GatesData(
      image:  'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      title: "Tourism to Egypt",
      badge: badgeData,
      onTap: () {}
  ),
];

final stories = [
  Story(
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: false,
    data:
    "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg",
  ),
  Story(
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: true,
    data:
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  ),
  Story(
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: true,
    data:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
  ),
  Story(
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: true,
    data:
    "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg",
  ),
  Story(
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: false,
    data:
    "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg",
  ),
  Story(
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: false,
    data:
    "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg",
  ),
];
final activities = [
  Activity(
    imageUrl:
    'https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg',
    title: 'FIFA World Cup',
    category: 'Sports',
    time: 'Nov 23, 12PM',
  ),
  Activity(
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    title: 'Morning Run',
    category: 'Running',
    time: 'Dec 2, 7AM',
  ),
];
final headerData1 = PostHeaderData(
  postId: '1',
  imageUrl:
  'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
  username: 'Sarah Ahmed',
  jobOrLocation: 'UI Designer',
  rate: 4.8,
  description:
  'This is a sample post description to test expandable text behavior in the feed.',
  isHighlighted: false,
);
final headerData2 = PostHeaderData(
  postId: '2',
  imageUrl:
  'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
  username: 'Sarah Ahmed',
  jobOrLocation: 'UI Designer',
  rate: 4.8,
  description:
  'This is a sample post description to test expandable text behavior in the feed.',
  isHighlighted: false,
);
final headerData3 = PostHeaderData(
  postId: '3',
  imageUrl:
  'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
  username: 'Sarah Ahmed',
  jobOrLocation: 'UI Designer',
  rate: 4.8,
  description:
  'This is a sample post description to test expandable text behavior in the feed.',
  isHighlighted: false,
);
final headerData4 = PostHeaderData(
  postId: '4',
  imageUrl:
  'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
  username: 'Sarah Ahmed',
  jobOrLocation: 'UI Designer',
  rate: 4.8,
  description:
  'This is a sample post description to test expandable text behavior in the feed.',
  isHighlighted: false,
);
final headerData5 = PostHeaderData(
  postId: '5',
  imageUrl:
  'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
  username: 'Sarah Ahmed',
  jobOrLocation: 'UI Designer',
  rate: 4.8,
  description:
  'This is a sample post description to test expandable text behavior in the feed.',
  isHighlighted: false,
);
final contentData = PostContentData(
  mediaUrls: [
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",
  ],
  commenterAvatars: [
    'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
    'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
  ],
  commentsCountText: '12',
);
final contentData1 = PostContentData(
  mediaUrls: [
    'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
    'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
  ],
  commenterAvatars: [
    'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
    'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
  ],
  commentsCountText: '12',
);
final contentData2 = PostContentData(
  mediaUrls: [],
  commenterAvatars: [
    'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
    'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
  ],
  commentsCountText: '12',
);
final contentData3 = PostContentData(
  mediaUrls: [
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",
  ],
  commenterAvatars: [],
  commentsCountText: '12',
);

List<PostData> postData = [
PostData(
headerData: headerData1,
contentData: contentData,
),
PostData(
headerData: headerData2,
contentData: contentData1,
),
PostData(
headerData: headerData3,
contentData: contentData2,
),
PostData(
headerData: headerData4,
contentData: contentData3,
),
PostData(
headerData: headerData5,
contentData: contentData,
),
];

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgetPassword,
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      path: AppRoutes.chooseGates,
      builder: (context, state) => ChooseGatesScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => HomeScreen(stories: stories, postData: postData, activities: activities),
    ),
    GoRoute(
      path: AppRoutes.video,
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

