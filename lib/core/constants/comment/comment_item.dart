import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/post_service_provider_header/header_avatar.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import 'comment_body.dart';
import 'comment_header.dart';
class CommentData {
  final String imageUrl;
  final String username;
  final String time;
  final Widget? trailing;
  final String comment;
  final bool isServiceProvider;

  const CommentData(
      this.imageUrl,
      this.username,
      this.time,
      this.trailing,
      this.comment,
      this.isServiceProvider,
      );
}


class CommentItem extends StatelessWidget {
  final CommentData data;

  const CommentItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.05),
            ),
          ],
          color:
              data.isServiceProvider ? AppColors.turnbullBlue : AppColors.lightSilver,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔹 ROW 1: avatar + name + time + icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderAvatar(imageUrl: data.imageUrl),
                SizedBox(width: 14.w),

                Expanded(
                  child: CommentHeader(
                    username: data.username,
                    time: data.time,
                    trailing: data.trailing,
                    isServiceProvider: data.isServiceProvider,
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            // 🔹 ROW 2: comment content
            CommentBody(
              comment: data.comment,
              isServiceProvider: data.isServiceProvider,
            ),
          ],
        ),
      ),
    );
  }
}
