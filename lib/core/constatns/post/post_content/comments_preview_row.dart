import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constatns/post/post_content/avatars_stack.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class CommentsPreviewRow extends StatelessWidget {
  final List<String> avatarUrls;
  final String commentsCountText;

  const CommentsPreviewRow({
    super.key,
    required this.avatarUrls,
    required this.commentsCountText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          AvatarsStack(avatarUrls: avatarUrls),

          SizedBox(width: 8.w),

          Text(
              "$commentsCountText comments",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.spanishGrey,
              )
          )
        ],
      ),
    );
  }
}