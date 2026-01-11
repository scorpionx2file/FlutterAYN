//name,time,and icon
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class CommentHeader extends StatelessWidget {
  final String username;
  final String time;
  final bool isServiceProvider;
  final Widget? trailing;

  const CommentHeader(
      {super.key,
    required this.username,
    required this.time,
    required this.trailing,
    required this.isServiceProvider}
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                username,
                style: AppTextStyles.description.copyWith(
                  color:
                  isServiceProvider ? AppColors.white : AppColors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                time,
                style: AppTextStyles.smallText.copyWith(
                  color:
                  isServiceProvider ? AppColors.white : AppColors.spanishGrey,
                ),
              )
            ],
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: 8.w),
          trailing!,
        ],
      ],
    );
  }
}
