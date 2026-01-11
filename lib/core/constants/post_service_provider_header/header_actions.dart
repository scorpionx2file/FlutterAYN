import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';

class HeaderActions extends StatelessWidget {
  final Color iconColor;
  final bool isHighlighted;
  final VoidCallback onMoreTap;

  const HeaderActions({
    super.key,
    required this.iconColor,
    required this.isHighlighted,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/icons/suitcase.png',
          width: 20.sp,
          height: 20.sp,
          color: iconColor,
        ),
        SizedBox(width: 5.w),
        IconButton(
          onPressed: onMoreTap,
          icon: Icon(
              Icons.more_horiz,
              size: 20.sp,
              color: isHighlighted ? AppColors.white : AppColors.spanishGrey
          ),
        ),
      ],
    );
  }
}
