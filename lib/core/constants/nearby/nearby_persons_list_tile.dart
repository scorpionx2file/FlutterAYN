import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/chat_button/chat_button.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../story_item/story_item.dart';

class NearbyPersonsListTile extends StatelessWidget {
  final Story story;
  final String name;
  final int miles;
  final VoidCallback onButtonPressed;
  final VoidCallback onStoryTap;
  final bool isServiceProvider;

  const NearbyPersonsListTile({
    super.key,
    required this.story,
    required this.name,
    required this.miles,
    required this.onButtonPressed,
    required this.onStoryTap,
    this.isServiceProvider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
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

          SizedBox(width: 8.w),

          // Name + Miles / Service Provider
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                // Dynamic text depending on service provider
                Text(
                  isServiceProvider ? 'Service Provider' : '$miles miles away',
                  style: AppTextStyles.description.copyWith(
                    color: AppColors.strongGrey,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Chat Button (blue if service provider, yellow otherwise)
          ChatButton(
            onTap: onButtonPressed,
            backgroundColor: isServiceProvider ? AppColors.turnbullBlue : AppColors.darkYellow
            ,
          ),
        ],
      ),
    );
  }
}
