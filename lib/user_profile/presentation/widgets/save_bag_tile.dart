import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class SavedBagTile extends StatelessWidget {
  const SavedBagTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/suitcase.png',
              width: 22.sp,
              height: 22.sp,
              color: AppColors.turnbullBlue,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: AppTextStyles.text.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Icon(
              Icons.chevron_right,
              size: 24.sp,
              color: AppColors.lightSilver,
            ),
          ],
        ),
      ),
    );
  }
}