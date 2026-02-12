import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class ProfileSettingsTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget? trailing; // toggle widget
  final VoidCallback? onTap;
  final bool hasPermission; // show toggle instead of arrow
  final Color? background;
  final Color? backArrowColor;

  const ProfileSettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.hasPermission = false, this.background, this.backArrowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: background ?? Colors.transparent,
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// MAIN ICON
                  icon,
                  //Icon(icon, size: 28.sp, color: AppColors.spanishGrey),

                  SizedBox(width: 12.w),

                  /// TITLE
                  Expanded(
                    child: Text(
                        title,
                        style: AppTextStyles.titles
                    ),
                  ),

                  /// Arrow or toggle on correct side
                  hasPermission
                      ? (trailing ?? SizedBox.shrink())
                      : Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: backArrowColor ?? AppColors.spanishGrey,
                  ),

                  SizedBox(width: 12.w),
                ],
              ),
            ),
          ),
        ),
        Divider(height: 1.h),
      ],
    );
  }
}
