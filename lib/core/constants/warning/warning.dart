import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';

class Warning extends StatelessWidget{
  final String warningTitle;
  final String warningContent;

  const Warning({
    super.key,
    required this.warningTitle,
    required this.warningContent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.h,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.pink,
          border: Border.all(
            color: AppColors.lebaneseRed,
            width: 1.w,
          ),
            borderRadius: BorderRadius.circular(8.r)
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/warning.png',
              width: 24.w,
              height: 24.h,
            ),

            SizedBox(width: 8.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  warningTitle,
                  style: AppTextStyles.text.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                  warningContent,
                  style: AppTextStyles.description,
                  overflow: TextOverflow.ellipsis,
                )
              ]
            )
          ]
        ),
      ),
    );
  }
}