import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/fonts/app_text_styles.dart';

class InfoScreenHeaderSection extends StatelessWidget {
  const InfoScreenHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.w),
        Text(
          " Enter your\n Information",
          style: AppTextStyles.headingH4,
        ),

        SizedBox(width: 35.w),

        Container(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12.w , vertical: 16.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              gradient: LinearGradient(
                colors: [
                  AppColors.babyPink,
                  AppColors.orange
                ],

              )
          ),
          child: Text(
            "Tour operator package",
            style: AppTextStyles.text.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    )
    ;
  }
}
