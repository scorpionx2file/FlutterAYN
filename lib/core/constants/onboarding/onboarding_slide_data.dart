import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class OnboardingSlideData {
  const OnboardingSlideData({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });

  final String imageAsset;
  final String title;
  final String subtitle;
}

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.data,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.titleColor = AppColors.black,
    this.subtitleColor = AppColors.spanishGrey,
  });

  final OnboardingSlideData data;

  final EdgeInsets padding;
  final Color titleColor;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    final contentPadding = padding.copyWith(
      left: padding.left.w,
      right: padding.right.w,
      top: padding.top.h,
      bottom: padding.bottom.h,
    );

    return Padding(
      padding: contentPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200.h,
            child: Image.asset(
              data.imageAsset,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            data.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.headingH2.copyWith(color: titleColor, height: 1.2),
          ),
          SizedBox(height: 20.h),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.text.copyWith(color: subtitleColor, height: 1.4),
          ),
        ],
      ),
    );
  }
}
