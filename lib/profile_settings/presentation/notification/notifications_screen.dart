import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../model/app_notification.dart';
import '../widgets/bell_badge.dart';
import '../widgets/notifications_list.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final items = <AppNotification>[
      const AppNotification(
        time: "14:41",
        title: "Notification title",
        body: "Tap to view details. This is a sample notification text.",
        unread: true,
      ),
      const AppNotification(
        time: "14:20",
        title: "Notification title",
        body: "Tap to view details. This is a sample notification text.",
        unread: false,
      ),
      const AppNotification(
        time: "13:05",
        title: "Notification title",
        body: "Tap to view details. This is a sample notification text.",
        unread: false,
      ),
      const AppNotification(
        time: "12:10",
        title: "Notification title",
        body: "Tap to view details. This is a sample notification text.",
        unread: false,
      ),
    ];

    final unreadCount = items.where((e) => e.unread).length;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: AppColors.black),
        ),
        title: Text(
          l10n.notificationsTitle,
          style: AppTextStyles.headingH3.copyWith(color: AppColors.black),
        ),
        actions: [
          BellBadge(count: unreadCount, onTap: () {}),
          SizedBox(width: 10.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: NotificationsList(
          items: items,
          avatarImage: const AssetImage("assets/images/profile.png"),
          onItemTap: (n) {
          },
          onMoreTap: (n) {
          },
        ),
      ),
    );
  }
}