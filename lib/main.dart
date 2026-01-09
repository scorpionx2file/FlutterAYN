import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/theme_data/theme_data_light.dart';
import 'core/constants/activity_card/activity_card.dart';
import 'core/constants/activity_card/activity_carousel.dart';
import 'core/constants/chat_button/chat_button.dart';
import 'core/constants/post/post.dart';
import 'core/constants/post/post_content/post_content.dart';
import 'core/constants/post_service_provider_header/post_or_service_provider_header.dart';
import 'core/constants/story_item/story_item.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit (
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final headerData = PostHeaderData(
          imageUrl: 'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
          themeMode: ThemeMode.light,
            home: Scaffold(
                body: SafeArea(
                  child: ActivityCarousel(
                    activities: [
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
                    ],
                    isYellow: true,
                  )
                  //ChatButton(onTap: (){},)
                 /* StoryItem(
                    imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
                    username: null,
                    isSeen: false,
                    onTap: () {},
                  )*//*Post(
                    headerData: headerData,
                    contentData: contentData,
                    onCommentTap: () {},
                    onShareTap: () {},
                    onMoreTap: () {  },
                  )*/,
                )
            )
        );
      },
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