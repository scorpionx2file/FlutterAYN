import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../core/constants/category_badge/category_badge.dart';
import '../../../core/theme/colors/app_colors.dart';

class MultiMediaRowController extends StatelessWidget {
  final int currentIndex;
  final int total;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const MultiMediaRowController({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: CategoryBadge(label: "tourism", isYellow: true),
        ),

        const Spacer(),

        _navTextButton(
          label: 'Previous',
          icon: Icons.arrow_back,
          onTap: onPrevious,
        ),

        SizedBox(width: 4.w),

        Text(
          '${currentIndex + 1} / $total',
          style: AppTextStyles.description.copyWith(
            color: AppColors.turnbullBlue
          ),
        ),

        SizedBox(width: 4.w),

        _navTextButton(
          label: 'next',
          icon: Icons.arrow_forward,
          isForward: true,
          onTap: onNext,
        ),
      ],
    );
  }

  Widget _navTextButton({
    required String label,
    required IconData icon,
    required VoidCallback? onTap,
    bool isForward = false,
  }) {
    final isDisabled = onTap == null;

    final color = isDisabled
        ? AppColors.spanishGrey
        : AppColors.turnbullBlue;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (!isForward)
            Icon(icon, size: 14.sp, color: color),

          SizedBox(width: 4.w),

          Text(
            label,
            style: AppTextStyles.description.copyWith(
              color: color,
            ),
          ),

          SizedBox(width: 4.w),

          if (isForward)
            Icon(icon, size: 14.sp, color: color),
        ],
      ),
    );
  }

}
