import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.time,
    required this.title,
    required this.body,
    required this.avatarImage,
    this.isUnread = false,
    this.onTap,
    this.onMoreTap,
  });

  final String time;
  final String title;
  final String body;
  final ImageProvider avatarImage;
  final bool isUnread;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 18.r, backgroundImage: avatarImage),
            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isUnread)
                        Container(
                          width: 7.w,
                          height: 7.w,
                          margin: EdgeInsets.only(right: 8.w, top: 3.h),
                          decoration: const BoxDecoration(
                            color: AppColors.lebaneseRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.text.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.description.copyWith(
                      color: AppColors.spanishGrey,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: AppTextStyles.description.copyWith(
                    color: AppColors.spanishGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                IconButton(
                  onPressed: onMoreTap,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.more_horiz,
                    size: 18.sp,
                    color: AppColors.spanishGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}