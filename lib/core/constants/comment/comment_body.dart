import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';

class CommentBody extends StatelessWidget {
  final String comment;
  final bool isServiceProvider;

  const CommentBody({
    super.key,
    required this.comment, required this.isServiceProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            comment,
            style: AppTextStyles.text.copyWith(
              color:
              isServiceProvider ? AppColors.white : AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
