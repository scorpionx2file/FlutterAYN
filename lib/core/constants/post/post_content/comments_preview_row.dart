import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import 'avatars_stack.dart';

class CommentsPreviewRow extends StatelessWidget {
  final List<String> avatarUrls;
  final String commentsCountText;
  final VoidCallback onCommentsTap;


  const CommentsPreviewRow({
    super.key,
    required this.avatarUrls,
    required this.commentsCountText,
    required this.onCommentsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          AvatarsStack(avatarUrls: avatarUrls),

          SizedBox(width: 8.w),

          GestureDetector(
            onTap: onCommentsTap,
            child: Text(
                "$commentsCountText comments",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.spanishGrey,
                )
            ),
          )
        ],
      ),
    );
  }
}