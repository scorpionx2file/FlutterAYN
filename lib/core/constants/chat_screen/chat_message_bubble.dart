import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class ChatMessageBubble extends StatelessWidget {
  final bool isMe;
  final String avatarUrl;
  final String message;
  final String time;

  const ChatMessageBubble({
    super.key,
    required this.isMe,
    required this.avatarUrl,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Avatar (Other User)
          if (!isMe) ChatAvatar(avatarUrl),
          if (!isMe) SizedBox(width: 12.w),

          /// Message Bubble
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 0.7.sw, // responsive bubble width
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? AppColors
                              .turnbullBlue // Sender bubble (blue)
                        : AppColors.white, // Receiver bubble (white)
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(isMe ? 16.r : 4.r),
                      bottomRight: Radius.circular(isMe ? 4.r : 16.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    textDirection: getTextDirection(message),
                    style: AppTextStyles.description.copyWith(
                      height: 1.4,
                      color: isMe ? AppColors.white : AppColors.black,
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                /// Time
                Text(
                  time,
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.spanishGrey,
                  ),
                ),
              ],
            ),
          ),

          if (isMe) SizedBox(width: 12.w),

          /// Avatar (Me)
          if (isMe) ChatAvatar(avatarUrl),
        ],
      ),
    );
  }

  /// Auto detect Arabic / English direction
  TextDirection getTextDirection(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }
}

class ChatAvatar extends StatelessWidget {
  final String avatarUrl;

  const ChatAvatar(this.avatarUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        radius: 24.r,
        backgroundImage: NetworkImage(avatarUrl),
      ),
    );
  }
}
