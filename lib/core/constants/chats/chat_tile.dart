import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../config/routes/router.dart';

class ChatTile extends StatelessWidget {
  final ChatTileModel chatModel;
  final VoidCallback? onTap;

  const ChatTile({super.key, required this.chatModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            AvatarSection(
              avatars: chatModel.avatars,
              isOnline: chatModel.isOnline,
            ),
            12.horizontalSpace,

            // Chat info: name + last message
            Expanded(
              child: ChatInfo(model: chatModel),
            ),
            8.horizontalSpace,

            // Right section: time + unread badge
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 60.w, // adjusts for smaller screens
              ),
              child: RightSection(model: chatModel),
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarSection extends StatelessWidget {
  final List<String> avatars;
  final bool isOnline;

  const AvatarSection({required this.avatars, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    if (avatars.length == 1) {
      return Stack(
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundImage: NetworkImage(avatars.first),
          ),
          if (isOnline)
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      );
    }

    return SizedBox(
      width: 52.w,
      height: 52.w,
      child: Stack(
        children: List.generate(
          avatars.length > 3 ? 3 : avatars.length,
              (index) {
            return Positioned(
              left: (index * 14).w,
              child: CircleAvatar(
                radius: 18.r,
                backgroundImage: NetworkImage(avatars[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChatInfo extends StatelessWidget {
  final ChatTileModel model;

  const ChatInfo({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Chat name: always fully visible
            Expanded(
              child: Text(
                model.chatName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.text.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            if (model.isServiceProvider)
              Padding(
                padding: EdgeInsets.only(left: 2.w), // smaller space
                child: Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Service Provider',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // may truncate if needed
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.turnbullBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        4.verticalSpace,
        // Last message preview wraps if too long
        Text(
          messagePreview(model),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.description.copyWith(color: AppColors.strongGrey),
        ),
      ],
    );
  }

  String messagePreview(ChatTileModel model) {
    switch (model.lastMessageType) {
      case ChatMessageType.voice:
        return '🎤 رسالة صوتية';
      case ChatMessageType.image:
        return '📷 صورة';
      case ChatMessageType.video:
        return '🎥 فيديو';
      case ChatMessageType.location:
        return '📍 موقع';
      case ChatMessageType.file:
        return '📎 ملف';
      case ChatMessageType.text:
      default:
        return model.lastMessageText ?? '';
    }
  }
}

class RightSection extends StatelessWidget {
  final ChatTileModel model;

  const RightSection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final unread = model.unreadCount ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          model.time,
          style: AppTextStyles.smallText.copyWith(color: AppColors.strongGrey),
        ),
        6.verticalSpace,
        if (unread > 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.turnbullBlue,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              unread.toString(),
              style: AppTextStyles.smallText.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
