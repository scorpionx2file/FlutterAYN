import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import '../../../../core/theme/fonts/app_text_styles.dart';

class TempSection extends StatelessWidget {
  final int maxTemp;
  final int minTemp;

  const TempSection({
    super.key,
    required this.maxTemp,
    required this.minTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wb_sunny,
              color: Colors.white,
              size: 22.sp,
            ),
            SizedBox(width: 6.w),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$maxTemp°",
                  style: AppTextStyles.text.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(
                  "/$minTemp°",
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.white,
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
