import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/colors/app_colors.dart';
import '../../../theme/fonts/app_text_styles.dart';

class ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
                icon,
                width: 20.sp,
                height: 20.sp,
                color: AppColors.spanishGrey
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey
              ),
            )
          ],
      ),
    );
  }
}