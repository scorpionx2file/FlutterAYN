import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/theme/theme_data/theme_data_light.dart';
import 'core/constatns/ProfileSettingsHeaderWidget.dart';
import 'core/constatns/post/post.dart';
import 'core/constatns/post/post_content/post_content.dart';
import 'core/constatns/post_service_provider_header/post_or_service_provider_header.dart';
import 'core/constatns/profileHeaderWidget.dart';

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
                  child: Post(
                    headerData: headerData,
                    contentData: contentData,
                    onCommentTap: () {},
                    onShareTap: () {},
                    onMoreTap: () {  },
                  ),
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