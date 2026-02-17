import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/auth/presentation/screen/choose_gates_screen.dart';
import 'package:traveller/auth/presentation/screen/forget_password_screen.dart';
import 'package:traveller/auth/presentation/screen/sign_in_screen.dart';
import 'package:traveller/auth/presentation/screen/welcome_auth_screen.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import 'package:traveller/event_option/presentation/widgets/bottom_section/event_list.dart';
import 'package:traveller/event_option/presentation/widgets/place_details_screen.dart';
import 'package:traveller/followers_list/presentation/widgets/followers_list_screen.dart';
import 'package:traveller/nearby_persons/presentation/widgets/nearby_persons_list_screen.dart';
import 'package:traveller/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:traveller/otp/presentation/screen/otp_screen.dart';
import 'package:traveller/profile_settings/presentation/profile/profile_settings_screen.dart';
import 'package:traveller/settings_contact/presentation/widgets/settings_contact_screen.dart';
import 'package:traveller/splash_screen.dart';
import 'package:traveller/stories/presentation/widgets/story_screen.dart';
import 'package:traveller/user_profile/presentation/screens/user_profile_screen.dart';
import 'package:traveller/video/presentation/widgets/video&articles_screen.dart';
import '../../auth/presentation/screen/sign_up_screen.dart';
import '../../core/constants/activity_card/activity_card.dart';
import '../../core/constants/comment/comment_item.dart';
import '../../core/constants/comment/rating_widget.dart';
import '../../core/constants/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import '../../core/constants/event_options/event_options_activities/event_options_activities.dart';
import '../../core/constants/event_options/event_options_posts/event_options_posts.dart';
import '../../core/constants/gate/app_gate_card.dart';
import '../../core/constants/post/post.dart';
import '../../core/constants/post/post_content/post_content.dart';
import '../../core/constants/post_service_provider_header/post_or_service_provider_header.dart';
import '../../core/constants/story_item/story_item.dart';
import '../../core/theme/colors/app_colors.dart';
import '../../core/utils/map_bottom_sheet_util.dart';
import '../../core/utils/post_utils.dart';
import '../../event_option/presentation/widgets/content_section/content_section.dart';
import '../../gates/presentation/screens/gates_screen.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../../map/presenttion/widgets/map_screen.dart';
import '../../profile_settings/presentation/notification/notifications_screen.dart';
import '../../profile_settings/presentation/terms_privacy/terms_privacy_screen.dart';
import '../../search/screen/search_results_screen.dart';
import '../../see_all_activities/presentation/screen/see_all_activities.dart';
import '../../user_profile/presentation/screens/saved_bags_screen.dart';
import '../../user_profile/presentation/screens/saved_posts_screen.dart';
import 'app_routes.dart';
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
    id: 'story20',
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: false,
    data:
    "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg",
  ),
  Story(
    id: 'story18',
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: true,
    data:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
  ),
  Story(
    id: 'story17',
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: true,
    data:
    "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg",
  ),
  Story(
    id: 'story16',
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: false,
    data:
    "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg",
  ),
  Story(
    id: 'story15',
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Habiba",
    isSeen: false,
    data:
    "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg",
  ),
];
final stories2 = [
  Story(
    id: 'story14',
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Jojo",
    isSeen: false,
    data:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
  ),
  Story(
    id: 'story13',
    imageUrl:
    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
    username: "Jojo",
    isSeen: true,
    data:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
  ),
];

final allStories = [
  stories,
  stories2
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

final List<MapItem> items = [
  /// 🟢 POST
  MapItem(
    location: LatLng(52.5200, 13.4050),
    type: MarkerType.post,
    imageUrl: postData[0].headerData.imageUrl,
    postData: postData[0].headerData,
    postContentData: postData[0].contentData,
    comments: postComments,
  ),

  /// 🔵 SERVICE PROVIDER
  MapItem(
    location: LatLng(48.8566, 2.3522),
    type: MarkerType.service,
    imageUrl: headerData1.imageUrl,
    serviceHeaderData: headerData1,
    locationText: "Paris, France",
    language: "English / French",
    comments: serviceProviderComments,
  ),
  MapItem(
    location: LatLng(50.1109, 8.6821),
    type: MarkerType.post,
    imageUrl: postData[1].headerData.imageUrl,
    postData: postData[1].headerData,
    postContentData: postData[1].contentData,
    comments: postComments,
  ),
  MapItem(
    location: LatLng(41.9028, 12.4964),
    type: MarkerType.service,
    imageUrl: headerData2.imageUrl,
    serviceHeaderData: headerData2,
    locationText: "Rome, Italy",
    language: "Italian / English",
    comments: serviceProviderComments,
  ),
];
final List<CommentData> postComments = [
  CommentData(
    'https://i.pravatar.cc/150?img=1',
    'Ahmed',
    '2h',
    const Icon(Icons.shopping_bag_rounded, color: AppColors.spanishGrey, size: 18),
    'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
    false,
  ),
  CommentData(
      'https://i.pravatar.cc/150?img=2',
      'Sara',
      '1h',
      const Icon(Icons.shopping_bag_rounded, color: AppColors.spanishGrey, size: 18),
      'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
      false
  ),
  CommentData(
      'https://i.pravatar.cc/150?img=3',
      'Omar',
      '10m',
      const Icon(Icons.shopping_bag_rounded, color: AppColors.spanishGrey, size: 18),
      'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
      false
  ),
];
final List<CommentData> serviceProviderComments = [
  CommentData(
    'https://i.pravatar.cc/150?img=1',
    'Ahmed',
    '2h',
    RatingWidget(rating: 4.8),
    'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
    true,
  ),
  CommentData(
      'https://i.pravatar.cc/150?img=2',
      'Sara',
      '1h',
      RatingWidget(rating: 4.8),
      'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
      true
  ),
  CommentData(
      'https://i.pravatar.cc/150?img=3',
      'Omar',
      '10m',
      RatingWidget(rating: 2.2),
      'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
      true
  ),
  CommentData(
      'https://i.pravatar.cc/150?img=3',
      'Omar',
      '10m',
      RatingWidget(rating: 2.2),
      'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
      true
  ),
  CommentData(
      'https://i.pravatar.cc/150?img=3',
      'Omar',
      '10m',
      RatingWidget(rating: 2.2),
      'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
      true
  ),
];

final placeCont = PlaceContent(
  maxTemp: 25,
  minTemp: 15,
  numOfPosts: 200,
  gateTitle: "Tourism to Egypt",
  gateDesc:
  "It is a long-established fact that the readable content of a page will distract the reader from focusing.",
  friendsImages: [
    'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
    'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
    'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
  ],
  numOfFriends: 200,
);
final placeInfo = PlaceInfoModel(
  gateName: "Egypt Gate",
  placeContent: placeCont,
);
final eventPosts = [
  EventPostsData(
    imageUrl:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
    username: "Habiba",
    title: "Morning Run",
    date: "Dec 2, 7AM",
    postImage:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
    rate: 4.8,
  ),
  EventPostsData(
    imageUrl:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
    username: "Habiba",
    title: "Morning Run",
    date: "Dec 2, 7AM",
    postImage:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
    rate: 4.8,
  ),
  EventPostsData(
    imageUrl:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
    username: "Habiba",
    title: "Morning Run",
    date: "Dec 2, 7AM",
    postImage:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
    rate: 4.8,
  ),
  EventPostsData(
    imageUrl:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
    username: "Habiba",
    title: "Morning Run",
    date: "Dec 2, 7AM",
    postImage:
    "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
    rate: 4.8,
  ),
];
final eventActivities = [
  EventActivitiesData(
      imageUrl:"https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
      title: 'French International Tour',
      date: '4 April',
      category: 'Sport'
  ),
  EventActivitiesData(
      imageUrl:"https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
      title: 'French International Tour',
      date: '4 April',
      category: 'Sport'
  ),
  EventActivitiesData(
      imageUrl:"https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
      title: 'French International Tour',
      date: '4 April',
      category: 'Sport'
  ),
  EventActivitiesData(
      imageUrl:"https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
      title: 'French International Tour',
      date: '4 April',
      category: 'Sport'
  ),
  EventActivitiesData(
      imageUrl:"https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
      title: '',
      date: '4 April',
      category: 'Sport'
  ),
];
final eventServiceProviders= [
  ServiceProviderData(
      data: headerData1,
      location: 'Egypt',
      language: 'English'
  ),
  ServiceProviderData(
      data: headerData2,
      location: 'Egypt',
      language: 'English'
  ),
  ServiceProviderData(
      data: headerData3,
      location: 'Egypt',
      language: 'English'
  ),
  ServiceProviderData(
      data: headerData4,
      location: 'Egypt',
      language: 'English'
  ),
  ServiceProviderData(
      data: headerData5,
      location: 'Egypt',
      language: 'English'
  )
];


class FollowerModel {
  final String name;
  final int points;
  final bool isFollowing;
  final Story story;

  FollowerModel({
    required this.name,
    required this.points,
    required this.isFollowing,
    required this.story,
  });
}
final List<FollowerModel> following = [
  FollowerModel(
    name: 'Adham Mohamed',
    points: 100,
    isFollowing: false,
    story: Story(
      id: 'story12',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: false,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Habiba Elhadi',
    points: 200,
    isFollowing: true,
    story: Story(
      id: 'story11',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: false,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Nourhan Essam',
    points: 300,
    isFollowing: false,
    story: Story(
      id: 'story10',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: false,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Nour Agami',
    points: 400,
    isFollowing: true,
    story: Story(
      id: 'story9',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: false,
      data: '',
    ),
  ),
];
final List<FollowerModel> followers = [
  FollowerModel(
    name: 'Bahaa Mahmoud Elsady',
    points: 535,
    isFollowing: false,
    story: Story(
      id: 'story8',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: false,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Ahmed Mohamed',
    points: 320,
    isFollowing: true,
    story: Story(
      id: 'story7',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: true,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Lina Adel',
    points: 150,
    isFollowing: false,
    story: Story(
      id: 'story6',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: true,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Dana Saeed',
    points: 200,
    isFollowing: true,
    story: Story(
      id: 'story5',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: true,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Basem Hany',
    points: 50,
    isFollowing: false,
    story: Story(
      id: 'story4',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: true,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Mira Hany',
    points: 200,
    isFollowing: true,
    story: Story(
      id: 'story3',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: true,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Hamad Yassin',
    points: 250,
    isFollowing: false,
    story: Story(
      id: 'story2',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: true,
      data: '',
    ),
  ),
  FollowerModel(
    name: 'Hamad Minshawy',
    points: 300,
    isFollowing: true,
    story: Story(
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: true,
      data: '',
      id: 'story1',
    ),
  ),
];

class NearbyPersonModel {
  final String name;
  final int miles;
  final bool isServiceProvider;
  final Story story;

  NearbyPersonModel({
    required this.name,
    required this.miles,
    required this.isServiceProvider,
    required this.story,
  });
}
final List<NearbyPersonModel> nearbyPersons = [
  NearbyPersonModel(
    name: 'Adham Mohamed',
    miles: 1,
    isServiceProvider: false,
    story: Story(
      id: 'story12',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: false,
      data: '',
    ),
  ),
  NearbyPersonModel(
    name: 'Habiba Elhadi',
    miles: 2,
    isServiceProvider: true,
    story: Story(
      id: 'story12',
      imageUrl:
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      isSeen: true,
      data: '',
    ),
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
      path: AppRoutes.savedPosts,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final title = (extra['title'] as String?) ?? "Saved Posts";
        final posts = (extra['posts'] as List<PostData>?) ?? <PostData>[];
        return SavedPostsScreen(title: title, posts: posts);
      },
    ),
    GoRoute(
      path: AppRoutes.searchResults,
      builder: (context, state) {
        final initialQuery = (state.extra as String?) ?? "";
        return SearchResultsScreen(
          initialQuery: initialQuery,
          peopleFollowing: following,
          peopleFollowers: followers,
          posts: postData,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: AppRoutes.termsPrivacy,
      builder: (context, state) => const TermsPrivacyScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomeAuthScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const SignUpScreen(),
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
      builder: (context, state) => const ChooseGatesScreen(),
    ),
    GoRoute(
      path: AppRoutes.savedBags,
      builder: (context, state) => SavedBagsScreen(posts: postData),
    ),
    GoRoute(
      path: AppRoutes.story,
      builder: (context, state) {
        final extra = state.extra as Map<String, int>? ?? {};
        final personIndex = extra["personIndex"] ?? 0;
        final startStoryIndex = extra["startStoryIndex"] ?? 0;

        return StoryScreen(
          allStories: allStories,
          personIndex: personIndex,
          startStoryIndex: startStoryIndex,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.video,
      builder: (context, state)  {
        final postData = state.extra as PostData;
        return VideoAndArticlesScreen(postData: postData);
      },
    ),
    GoRoute(
      path: AppRoutes.gateDetails,
      builder: (context, state) => PlaceDetailsScreen(placeInfo: placeInfo,posts: eventPosts,activities: eventActivities,services: eventServiceProviders,),
    ),
    GoRoute(
      path: AppRoutes.followersList,
      builder: (context, state) => FollowersListScreen(following: following, followers: followers),
    ),
    GoRoute(
      path: AppRoutes.profileSettings,
      builder: (context, state) => ProfileSettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.settingsContact,
      builder: (context, state) => SettingsContactScreen(),
    ),
    GoRoute(
      path: '/post/:id', // <-- deep link route
      builder: (context, state) {
        final postId = state.pathParameters['id']!;
        final post = findPostById(postId);

        if (post == null) {
          return Scaffold(
            body: Center(child: Text(context.l10n.postNotFound)),
          );
        }

        return VideoAndArticlesScreen(postData: post);
      },
    ),
    GoRoute(
      path: AppRoutes.nearbyPersonsAndChatsList,
      builder: (context, state) => NearbyPersonsAndChatsListScreen(nearbyPersons: nearbyPersons,chats: []),
    ),

    // ShellRoute for main screens with bottom nav
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              /// Main Screen
              Positioned.fill(child: child),

              /// Bottom Nav + FAB Menu (ON TOP)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: const CustomBottomNavigationBar(),
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) =>
              HomeScreen(stories: stories, postData: postData, activities: activities),
        ),
        GoRoute(
          path: AppRoutes.map, // you can define a route for your map screen
          builder: (context, state) => MapScreen(
            items: items,
            onMarkerTab: (item) {
              openMapItemBottomSheet(context, item);
            },
          ),
        ),
        GoRoute(
          path: AppRoutes.gates,
          builder: (context, state) => GatesScreen(gates: gates),
        ),
        GoRoute(
          path: AppRoutes.profile, // route for profile
          builder: (context, state) => UserProfileScreen(activities: activities, postData: postData),
        ),
        GoRoute(
          path: AppRoutes.seeAllActivities,
          builder: (context, state) {
            final activities = state.extra as List<Activity>;
            return SeeAllActivities(activities: activities);
          },
        ),
      ],
    ),
  ],
);

