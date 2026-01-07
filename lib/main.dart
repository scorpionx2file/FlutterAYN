import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/theme/theme_data/theme_data_light.dart';
import 'core/constatns/ProfileSettingsHeaderWidget.dart';
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
          themeMode: ThemeMode.light,
            home: Scaffold(
                body: SafeArea(
                  child: ProfileSettingsHeaderWidget(
                    isProfileSettings: true,
                    name: 'محمود السعدي',
                    username: 'username',
                    isVerified: true,
                    profileImage: const AssetImage('assets/images/profile.png'),
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