import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../theme/colors/app_colors.dart';

class ProfileSettingsHeader extends StatelessWidget {
  final String name;
  final String username;
  final ImageProvider profileImage;
  final bool isVerified;
  final bool isProfileSettings;
  final VoidCallback? onEditPressed;
  final VoidCallback? onBackPressed;

  const ProfileSettingsHeader({
    super.key,
    required this.name,
    required this.username,
    required this.profileImage,
    this.isVerified = false,
    this.isProfileSettings = false,
    this.onEditPressed,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.turnbullBlue,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// ================= ORIGINAL DESIGN (UNTOUCHED) =================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// VERIFICATION ICON
                        if (isVerified) ...[
                          SizedBox(width: 4.w),
                          _verificationIcon(),
                        ],
                        SizedBox(width: 6.w),
                        /// NAME
                        Text(
                          name,
                          style: AppTextStyles.text.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    /// USERNAME
                    Text(
                      '@$username',
                      style: AppTextStyles.description.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 16.w),

                /// PROFILE
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: AppColors.white,
                  child: CircleAvatar(
                    radius: 38.r,
                    backgroundImage: profileImage,
                  ),
                ),
              ],
            ),
          ),

          /// ================= ADDITIONS (ARROW – EDIT BUTTON) =================

          /// ARROW
          if (isProfileSettings)
            Positioned(
              left: 8.w,
              top: 0.h,
              bottom: 0.h,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.white,
                    size: 18.sp,
                  ),
                  onPressed:
                      onBackPressed ??
                      () {
                        Navigator.pop(context);
                      },
                ),
              ),
            ),

          /// EDIT BUTTON AS TEXT BUTTON
          if (isProfileSettings)
            Positioned(
              left: 100.w,
              bottom: 6.h,
              child: TextButton.icon(
                onPressed: onEditPressed,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                icon: Icon(Icons.edit, color: AppColors.white, size: 16.sp),
                label: Text(
                  "تعديل الحساب",
                  style: AppTextStyles.description.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _verificationIcon() {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check, size: 10.sp, color: AppColors.turnbullBlue),
    );
  }
}
