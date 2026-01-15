import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/fonts/app_text_styles.dart';

class UserProfilePopup extends StatelessWidget {
  const UserProfilePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 8.w,
          top: 110.h,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 180.w,
              padding: EdgeInsets.symmetric(vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 10.r)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  popupItem(
                    icon: Icons.share,
                    text: 'Share Profile',
                    onTap: () => Navigator.pop(context),
                  ),
                  popupItem(
                    icon: Icons.comments_disabled,
                    text: 'Mute Messages',
                    onTap: () => Navigator.pop(context),
                  ),
                  popupItem(
                    icon: Icons.block,
                    text: 'Block Profile',
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget popupItem({
    required IconData icon,
    required String text,
    Color iconColor = AppColors.turnbullBlue,
    Color textColor = AppColors.black,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          // textDirection: TextDirection.rtl,
          children: [
            Icon(icon, size: 20.sp, color: iconColor),
            SizedBox(width: 10.w),
            Text(text, style: AppTextStyles.text.copyWith(color: textColor)),
          ],
        ),
      ),
    );
  }
}
