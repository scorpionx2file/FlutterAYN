import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../../theme/colors/app_colors.dart';

class CategoryBadge extends StatelessWidget {
  final String label;
  final bool isYellow;

  const CategoryBadge({
    super.key,
    required this.label,
    this.isYellow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isYellow ? AppColors.darkYellow : AppColors.violet,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.button.copyWith(
          color: isYellow ? AppColors.black : AppColors.white
        ),
      ),
    );
  }
}
