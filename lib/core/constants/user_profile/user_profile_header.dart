import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/chat_button/chat_button.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../user_profile/presentation/widgets/user_profile_pop-up.dart';
import '../../theme/colors/app_colors.dart';

class UserProfileHeader extends StatefulWidget {
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
  State<UserProfileHeader> createState() => _UserProfileHeaderState();
}

class _UserProfileHeaderState extends State<UserProfileHeader>
    with SingleTickerProviderStateMixin {
  /// Controller to manage the expand/collapse animation of points
  bool isPointsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          /// ===== COVER IMAGE =====
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.coverImage,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      AppColors.black.withOpacity(0.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),

              /// ===== TOP ACTIONS (MY PROFILE ONLY) =====
              if (widget.isMyProfile)
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

              /// ===== SETTINGS ACTION (OTHER USER PROFILE ONLY) =====
              if (!widget.isMyProfile)
                Positioned(
                  bottom: 16.h,
                  left: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: AppColors.black.withOpacity(0.3),
                        builder: (_) => const UserProfilePopup(),
                      );
                    },
                    child: settingsIcon(Icons.info),
                  ),
                ),

              /// ===== PROFILE IMAGE =====
              Positioned(
                bottom: -30.h,
                right: 16.w,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage: widget.profileImage,
                    ),

                    /// VERIFIED (OTHER USERS)
                    if (widget.isVerified && !widget.isMyProfile)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: verificationIcon(),
                      ),

                    /// CAMERA (MY PROFILE)
                    if (widget.isMyProfile)
                      Positioned(bottom: 0, right: 0, child: cameraIcon()),
                  ],
                ),
              ),

              /// ===== USERNAME + JOB TITLE =====
              Positioned(
                bottom: 12.h,
                right: 16.w + 90.w,
                child: Row(
                  children: [
                    if (!widget.isMyProfile && widget.jobTitle != null) ...[
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
                          widget.jobTitle!,
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
                        if (widget.isMyProfile && widget.isVerified) ...[
                          verificationIcon(),
                          SizedBox(width: 6.w),
                        ],
                        Text(
                          widget.username,
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

          /// ===== BIO + LOCATION + SOCIAL ICONS =====
          Padding(
            padding: EdgeInsets.only(
              right: widget.isMyProfile ? (16.w + 90.w) : 30.w,
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
                        widget.bio,
                        style: AppTextStyles.description,
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.location,
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
                SizedBox(width: widget.isMyProfile ? 0.w : 22.w),

                if (!widget.isMyProfile)
                  Column(
                    children: [
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          if (widget.onTwitterTap != null)
                            GestureDetector(
                              onTap: widget.onTwitterTap,
                              child: Image.asset(
                                'assets/images/icons/twitter.png',
                                width: 24.w,
                                height: 24.h,
                              ),
                            ),
                          if (widget.onTwitterTap != null &&
                              widget.onSnapchatTap != null)
                            SizedBox(width: 6.w),
                          if (widget.onSnapchatTap != null)
                            GestureDetector(
                              onTap: widget.onSnapchatTap,
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

          /// ===== NUMBERS SECTION =====
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  statNumberColumn(
                    widget.firstNumber,
                    "يتابع",
                    "assets/images/icons/people.png",
                  ),
                  statNumberColumn(
                    widget.secondNumber,
                    "يتابعه",
                    "assets/images/icons/people.png",
                  ),

                  /// ===== POINTS (EXPANDABLE FOR MY PROFILE) =====
                  GestureDetector(
                    onTap: widget.isMyProfile
                        ? () {
                            setState(() {
                              isPointsExpanded = !isPointsExpanded;
                            });
                          }
                        : null,
                    child: statNumberColumn(
                      widget.thirdNumber,
                      "النقاط",
                      "assets/images/icons/points.png",
                    ),
                  ),
                ],
              ),

              /// ===== EXPANDABLE POINTS COMPONENT =====
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isPointsExpanded && widget.isMyProfile
                    ? Container(
                        width: double.infinity, // Full width
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.neonCoral,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Flexible height
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TOTAL POINTS
                            Row(
                              children: [
                                Text(
                                  "Total Points",
                                  style: AppTextStyles.titles.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  widget.thirdNumber.toString(),
                                  style: AppTextStyles.headingH3.copyWith(
                                    color: AppColors.darkYellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12.h),

                            /// LEVEL BAR
                            pointsProgressBar(widget.thirdNumber),

                            SizedBox(height: 12.h),

                            /// FEATURES
                            Text(
                              "Premium Package Features",
                              style: AppTextStyles.titles.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 6.h),

                            pointsFeatureItem(
                              "Explanation of one of the features of the Premium package",
                            ),
                            pointsFeatureItem(
                              "Explanation of one of the features of the Premium package",
                            ),
                            pointsFeatureItem(
                              "Explanation of one of the features of the Premium package",
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),

          /// ===== CHAT & FOLLOW BUTTONS (USER PROFILE ONLY) =====
          if (!widget.isMyProfile) ...[
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                children: [
                  Flexible(
                    flex: 1, // Chat button gets 1 share
                    child: ChatButton(onTap: () {}),
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    flex: 2, // Follow button gets 2 shares (wider)
                    child: AppButton(
                      text: "Follow",
                      icon: Icon(Icons.person_add, size: 20),
                      height: 30.h,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],

          /// ===== EDIT MY INFORMATION BUTTON (MY PROFILE ONLY) =====
          if (widget.isMyProfile) ...[
            SizedBox(height: 8.h),
            AppButton(
              text: 'Edit My Information',
              icon: Icon(Icons.edit_calendar_rounded),
              height: 32.h,
              width: 290.w,
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.turnbullBlue,
              borderSide: BorderSide(
                color: AppColors.turnbullBlue,
                width: 1.5.w,
              ),
              onPressed: () {},
            ),
          ],
        ],
      ),
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

  Widget pointsProgressBar(int totalPoints) {
    final List<int> levels = [50, 200, 400, 650, 800, 1000, 1200, 1500];

    return LayoutBuilder(
      builder: (context, constraints) {
        final double fullWidth = constraints.maxWidth;
        final double stepWidth = fullWidth / (levels.length - 1);

        // Find the index of the previous and next levels
        int prevLevelIndex = levels.lastIndexWhere(
          (level) => totalPoints >= level,
        );
        int nextLevelIndex = (prevLevelIndex + 1 < levels.length)
            ? prevLevelIndex + 1
            : prevLevelIndex;

        // Interpolate progress between the two levels
        double progressWidth;
        if (prevLevelIndex == nextLevelIndex) {
          // Already at last level
          progressWidth = stepWidth * prevLevelIndex;
        } else {
          final int prevLevel = levels[prevLevelIndex];
          final int nextLevel = levels[nextLevelIndex];
          final double fraction =
              (totalPoints - prevLevel) / (nextLevel - prevLevel);
          progressWidth = stepWidth * prevLevelIndex + stepWidth * fraction;
        }

        return Column(
          children: [
            /// Progress Bar
            Container(
              height: 8.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: progressWidth,
                  decoration: BoxDecoration(
                    color: AppColors.darkYellow,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 4.h), // space between bar and dots

            /// Dots + Crown + Numbers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(levels.length, (index) {
                bool isActive = totalPoints >= levels[index];
                bool isLast = index == levels.length - 1;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Dot
                        Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive
                                ? AppColors.darkYellow
                                : AppColors.white.withOpacity(0.4),
                          ),
                        ),

                        // Crown for last level
                        if (isLast)
                          Positioned(
                            top: -22.h,
                            child: Icon(
                              Icons.emoji_events,
                              size: 22.sp,
                              color: AppColors.darkYellow,
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // Level number
                    Text(
                      levels[index].toString(),
                      style: AppTextStyles.description.copyWith(
                        color: AppColors.white,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Widget pointsFeatureItem(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(Icons.add_circle, color: AppColors.white, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.text.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
