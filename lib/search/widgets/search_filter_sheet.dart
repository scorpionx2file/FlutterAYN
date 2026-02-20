import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class SearchFilterSheet extends StatelessWidget {
  const SearchFilterSheet({
    super.key,
    required this.initialIndex,
  });

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final labels = <String>[
      l10n.tabPeople,
      l10n.tabPlaces,
      l10n.tabServices,
      l10n.tabEvents,
    ];

    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 14.h,
        bottom: 16.h + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.lightSilver,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            l10n.filter,
            style: AppTextStyles.titles.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),

          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: List.generate(labels.length, (i) {
              final isSelected = i == initialIndex;

              return ChoiceChip(
                label: Text(labels[i]),
                selected: isSelected,
                onSelected: (_) => Navigator.pop(context, i),
                selectedColor: AppColors.turnbullBlue,
                backgroundColor: AppColors.white,
                labelStyle: AppTextStyles.title.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.white : AppColors.strongGrey,
                ),
                side: BorderSide(color: AppColors.lightSilver),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              );
            }),
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}