import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../theme/colors/app_colors.dart';

class UserProfileHeader extends StatelessWidget {
  final bool isMyProfile;
  final bool isVerified;

  final ImageProvider coverImage;
  final ImageProvider profileImage;

  final String username;
  final String bio;
  final String location;

  final int thirdNumber;
  final int secondNumber;
  final int firstNumber;

  final String? jobTitle;
  final VoidCallback? onTwitterTap;
  final VoidCallback? onSnapchatTap;

  const UserProfileHeader({
    super.key,
    this.isVerified = true,
    this.isMyProfile = false,
    required this.coverImage,
    required this.profileImage,
    required this.username,
    required this.bio,
    required this.location,
    required this.thirdNumber,
    required this.secondNumber,
    required this.firstNumber,
    this.jobTitle,
    this.onTwitterTap,
    this.onSnapchatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// COVER IMAGE
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: coverImage,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),

            /// TOP ACTIONS (MY PROFILE ONLY)
            if (isMyProfile)
              Positioned(
                top: 28.h,
                left: 16.w,
                child: Row(
                  children: [
                    topHeaderIcon(Icons.chat_bubble_outline, 'رسائل'),
                    SizedBox(width: 16.w),
                    topHeaderIcon(Icons.work_outline, 'حقائب'),
                  ],
                ),
              ),

            /// SETTINGS ACTION (USER PROFILE ONLY)
            if (!isMyProfile)
              Positioned(
                bottom: 16.h,
                left: 8.w,
                child: settingsIcon(Icons.info),
              ),

            /// PROFILE IMAGE
            Positioned(
              bottom: -30.h,
              right: 16.w,
              child: Stack(
                children: [
                  CircleAvatar(radius: 40.r, backgroundImage: profileImage),

                  /// VERIFIED (OTHER USERS)
                  if (isVerified && !isMyProfile)
                    Positioned(bottom: 0, right: 0, child: verificationIcon()),

                  /// CAMERA (MY PROFILE)
                  if (isMyProfile)
                    Positioned(bottom: 0, right: 0, child: cameraIcon()),
                ],
              ),
            ),

            /// USERNAME + JOB TITLE
            Positioned(
              bottom: 12.h,
              right: 16.w + 90.w,
              child: Row(
                children: [
                  if (!isMyProfile && jobTitle != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.turnbullBlue,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        jobTitle!,
                        style: AppTextStyles.description.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (isMyProfile && isVerified) ...[
                        verificationIcon(),
                        SizedBox(width: 6.w),
                      ],
                      Text(
                        username,
                        style: AppTextStyles.text.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 32.h),

        /// BIO + LOCATION + SOCIAL
        Padding(
          padding: EdgeInsets.only(
            right: isMyProfile ? (16.w + 90.w) : 30.w,
            left: 30.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// BIO + LOCATION
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      bio,
                      style: AppTextStyles.description,
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          location,
                          style: AppTextStyles.description.copyWith(
                            color: AppColors.spanishGrey,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.location_on,
                          size: 14.sp,
                          color: AppColors.turnbullBlue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// SPACE / SOCIAL ICONS
              SizedBox(width: isMyProfile ? 0.w : 22.w),

              if (!isMyProfile)
                Column(
                  children: [
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        if (onTwitterTap != null)
                          GestureDetector(
                            onTap: onTwitterTap,
                            child: Image.asset(
                              'assets/images/icons/twitter.png',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        if (onTwitterTap != null && onSnapchatTap != null)
                          SizedBox(width: 6.w),
                        if (onSnapchatTap != null)
                          GestureDetector(
                            onTap: onSnapchatTap,
                            child: Image.asset(
                              'assets/images/icons/snapchat.png',
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        /// NUMBERS
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              statNumberColumn(
                firstNumber,
                "يتابع",
                "assets/images/icons/people.png",
              ),
              statNumberColumn(
                secondNumber,
                "يتابعه",
                "assets/images/icons/people.png",
              ),
              statNumberColumn(
                thirdNumber,
                "النقاط",
                "assets/images/icons/points.png",
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ===== Helpers =====

  Widget statNumberColumn(int value, String label, String iconPath) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.description.copyWith(
            color: AppColors.spanishGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Image.asset(iconPath, width: 20.w, height: 20.h),
            SizedBox(width: 6.w),
            Text(
              value.toString(),
              style: AppTextStyles.headingH3.copyWith(color: AppColors.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget verificationIcon() {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: const BoxDecoration(
        color: AppColors.turnbullBlue,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.check, size: 14.sp, color: AppColors.white),
    );
  }

  Widget cameraIcon() {
    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: const BoxDecoration(
        color: AppColors.spanishGrey,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.camera_alt, size: 14.sp, color: AppColors.white),
    );
  }

  Widget topHeaderIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.white, size: 22.sp),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTextStyles.description.copyWith(color: AppColors.white),
        ),
      ],
    );
  }

  Widget settingsIcon(IconData icon) {
    return Icon(icon, color: AppColors.white, size: 22.sp);
  }
}
