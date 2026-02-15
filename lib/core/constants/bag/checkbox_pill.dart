import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class CheckBoxPill extends StatelessWidget {
  const CheckBoxPill({super.key, required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      height: 18.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: selected ? AppColors.turnbullBlue : AppColors.lightSilver,
          width: 1.4,
        ),
        color: selected
            ? AppColors.turnbullBlue.withOpacity(0.12)
            : Colors.transparent,
      ),
      child: selected
          ? Icon(Icons.check, size: 14.sp, color: AppColors.turnbullBlue)
          : const SizedBox.shrink(),
    );
  }
}