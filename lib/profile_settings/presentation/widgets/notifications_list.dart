import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import '../model/app_notification.dart';
import 'notification_item.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({
    super.key,
    required this.items,
    required this.avatarImage,
    this.onItemTap,
    this.onMoreTap,
  });

  final List<AppNotification> items;
  final ImageProvider avatarImage;
  final ValueChanged<AppNotification>? onItemTap;
  final ValueChanged<AppNotification>? onMoreTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => Divider(height: 18.h, color: AppColors.lightSilver),
      itemBuilder: (_, i) {
        final n = items[i];
        return NotificationItem(
          time: n.time,
          title: n.title,
          body: n.body,
          isUnread: n.unread,
          avatarImage: avatarImage,
          onTap: () => onItemTap?.call(n),
          onMoreTap: () => onMoreTap?.call(n),
        );
      },
    );
  }
}