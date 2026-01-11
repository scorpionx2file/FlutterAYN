import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/report/report_bottom_sheet.dart';
import 'package:traveller/core/theme/theme_data/theme_data_light.dart';
import 'core/constants/activity_card/activity_card.dart';
import 'core/constants/followers_list/followers_list_tile.dart';
import 'core/constants/post/post.dart';
import 'core/constants/post/post_content/post_content.dart';
import 'core/constants/post_service_provider_header/post_or_service_provider_header.dart';
import 'core/constants/story_item/story_item.dart';
import 'home/presentation/widgets/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
          themeMode: ThemeMode.light,
          home: child,
        );
      },

      child: const HomeRoot(),
    );
  }
}




class HomeRoot extends StatelessWidget {
  const HomeRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final headerData = PostHeaderData(
      imageUrl:
      'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
      username: 'Sarah Ahmed',
      jobOrLocation: 'UI Designer • Cairo',
      rate: 4.8,
      postTitle: 'Looking for feedback',
      date: '2h',
      description:
      'This is a sample post description to test expandable text behavior in the feed.',
      isHighlighted: true,
    );

        final contentData = PostContentData(
          mediaUrls: [
            "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",
            "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4"
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
          mediaUrls: [
          ],
          commenterAvatars: [
            'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
            'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
          ],
          commentsCountText: '12',
        );

        final contentData3 = PostContentData(
          mediaUrls: [
            "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",
            "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4"
          ],
          commenterAvatars: [],
          commentsCountText: '12',
        );

        final stories = [
          Story(
            imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
            username: "Habiba",
            isSeen: true
          ),
          Story(
            imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
            username: "Habiba",
            isSeen: true
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: true
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false
          ),
        ];

        final activities = [
          Activity(
            imageUrl: 'https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg',
            title: 'FIFA World Cup',
            category: 'Sports',
            time: 'Nov 23, 12PM',
          ),
          Activity(
            imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
            title: 'Morning Run',
            category: 'Running',
            time: 'Dec 2, 7AM',
          ),
        ];

        final posts = [
          PostData(
            headerData: headerData,
            contentData: contentData,
          ),
          PostData(
            headerData: headerData,
            contentData: contentData1,
          ),
          PostData(
            headerData: headerData,
            contentData: contentData2,
          ),
          PostData(
            headerData: headerData,
            contentData: contentData3,
          ),
          PostData(
            headerData: headerData,
            contentData: contentData,
          ),
        ];

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
          themeMode: ThemeMode.light,
            home: Scaffold(
                body: SafeArea(
                  child: HomeScreen(
                    stories: stories,
                    postData: posts,
                    activities: activities
                  )
                )
            )
        );
  }
}

/// UserProfileHeaderWidget
// UserProfileHeaderWidget(
// isMyProfile: true,
// isVerified: true,
// coverImage: const AssetImage('assets/images/profileCover.png'),
// profileImage: const AssetImage('assets/images/profile.png'),
// username: 'محمود السعدي',
// jobTitle: 'مقدم خدمة',
// bio:
// 'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيُلهي القارئ',
// location: 'الغردقة، مصر',
// leftNumber: 735,
// middleNumber: 31700,
// rightNumber: 1689,
// onTwitterTap: () {},
// onSnapchatTap: () {},
// ),

/// FollowersListTile
// FollowersListTile(
// story: Story(
// imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
// isSeen: false
// ),
// name: 'Adham Mohamed',
// points: 535,
// buttonText: 'Follow',
// isFollowing: false,
// onButtonPressed: () {},
// onStoryTap: () {},
// )