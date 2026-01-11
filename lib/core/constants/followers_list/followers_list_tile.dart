import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../story_item/story_item.dart';

class FollowersListTile extends StatelessWidget {
  final Story story;
  final String name;
  final int points;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final VoidCallback onStoryTap;
  final bool isFollowing;

  const FollowersListTile({
    super.key,
    required this.story,
    required this.name,
    required this.points,
    required this.buttonText,
    required this.onButtonPressed,
    required this.onStoryTap,
    this.isFollowing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          // Story
          SizedBox(
            height: 60.h,
            child: StoryItem(
              imageUrl: story.imageUrl,
              isSeen: story.isSeen,
              onTap: onStoryTap,
            ),
          ),

          SizedBox(width: 12.w),

          // Name + Points
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  name,
                  style: AppTextStyles.text,
                  maxLines: 1, // keep on one line
                  overflow: TextOverflow.ellipsis, // show ... if too long
                ),
                SizedBox(height: 2.h),
                // Points
                Text(
                  '$points Points',
                  style: AppTextStyles.description.copyWith(
                    color: AppColors.strongGrey,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Follow Button
          AppButton(
            text: buttonText,
            width: 130,
            height: 40,
            backgroundColor:
            isFollowing ? AppColors.white : AppColors.turnbullBlue,
            foregroundColor:
            isFollowing ? AppColors.turnbullBlue : AppColors.white,
            borderSide: isFollowing
                ? BorderSide(color: AppColors.turnbullBlue, width: 1.5.w)
                : BorderSide.none,
            elevation: 0,
            onPressed: onButtonPressed,
          ),
        ],
      )

    );
  }

}
