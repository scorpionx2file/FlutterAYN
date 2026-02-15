import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class CreateNewBagRow extends StatelessWidget {
  const CreateNewBagRow({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(
              Icons.add_circle_outline,
              color: AppColors.turnbullBlue,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: AppTextStyles.text.copyWith(
                color: AppColors.turnbullBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}