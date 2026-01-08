import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class ProfileSettingsTileSegmentedToggle extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const ProfileSettingsTileSegmentedToggle({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.turnbullBlue, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          final selected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: selected ? AppColors.turnbullBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Text(
                options[index],
                style: selected
                    ? AppTextStyles.button.copyWith(color: AppColors.white)
                    : AppTextStyles.description.copyWith(
                        color: AppColors.turnbullBlue,
                      ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
