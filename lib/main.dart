import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/theme_data/theme_data_light.dart';
import 'config/routes/router.dart';
import 'core/constants/chat_screen/chat_message_bubble.dart';
import 'l10n/app_localizations.dart';

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
        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: getLightTheme(),
          themeMode: ThemeMode.light,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}

/// Chat Message Bubble
// ScreenUtilInit(
// designSize: const Size(360, 690),
// builder: (_, __) {
// return MaterialApp(
// debugShowCheckedModeBanner: false,
// home: Scaffold(
// appBar: AppBar(title: const Text('Chat Test')),
// body: ListView(
// padding: EdgeInsets.only(top: 16.h),
// children: [
// ChatMessageBubble(
// message: 'مرحبا أهلا بك في التطبيق',
// isMe: false,
// avatarUrl: 'https://i.pravatar.cc/150?img=5',
// time: '16 min ago',
// ),
// ChatMessageBubble(
// message: 'Sweet, Welcome !! 😊',
// isMe: true,
// avatarUrl: 'https://i.pravatar.cc/150?img=12',
// time: '15 min ago',
// ),
// ChatMessageBubble(
// message: 'I was Reading your profile, Interest',
// isMe: false,
// avatarUrl: 'https://i.pravatar.cc/150?img=5',
// time: '16 min ago',
// ),
// ChatMessageBubble(
// message: 'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء 😍',
// isMe: false,
// avatarUrl: 'https://i.pravatar.cc/150?img=5',
// time: '16 min ago',
// ),
// ],
// ),
// ),
// );
// },
// );


