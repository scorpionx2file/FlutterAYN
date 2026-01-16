import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class OnboardingDots extends StatelessWidget {
  const OnboardingDots({
    super.key,
    required this.count,
    required this.index,
  });

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: active ? 18.w : 7.w,
          height: 7.w,
          decoration: BoxDecoration(
            color: active ? AppColors.turnbullBlue : AppColors.lightSilver,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}
