import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class StoryDivider extends StatelessWidget {
  final int storyNumbers;
  final int currentIndex;
  final double progress;

  const StoryDivider({
    super.key,
    required this.storyNumbers,
    required this.currentIndex,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: List.generate(storyNumbers, (index) {
          Color bgColor;

          if (index < currentIndex) {
            bgColor = AppColors.white; // passed
          } else {
            bgColor = AppColors.spanishGrey; // upcoming
          }

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 3.h,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(2),
              ),
              child: index == currentIndex
                  ? FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  color: AppColors.white,
                ),
              )
                  : null,
            ),
          );
        }),
      ),
    );
  }
}