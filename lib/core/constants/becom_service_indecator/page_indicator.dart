import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
         SizedBox(width: 14.w),

        /// Lines
        Row(
          children: List.generate(
            total,
                (index) => Container(
              width: 10.w,
              height: 2.h,
              margin:  EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                color: index == currentIndex
                    ? AppColors.black
                    : AppColors.spanishGrey,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        ),

         SizedBox(width: 8.w),

        Text(
          '${currentIndex + 1}/$total',
          style: AppTextStyles.text,
        ),
      ],
    );
  }
}
