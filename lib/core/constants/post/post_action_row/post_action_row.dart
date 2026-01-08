import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:traveller/core/theme/colors/app_colors.dart';

import 'action_button.dart';

class PostActionsRow extends StatelessWidget {
  final VoidCallback onCommentTap;
  final VoidCallback onShareTap;

  const PostActionsRow({
    super.key,
    required this.onCommentTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: ActionButton(
                icon: 'assets/images/icons/share.png',
                label: 'Share',
                onTap: onShareTap,
              ),
            ),

            VerticalDivider(
              width: 1.w,
              thickness: 1,
              color: AppColors.spanishGrey,
            ),

            Expanded(
              child: ActionButton(
                icon: 'assets/images/icons/comment.png',
                label: 'Comment',
                onTap: onCommentTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}