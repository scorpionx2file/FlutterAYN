import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class SearchCategoryTabs extends StatelessWidget {
  const SearchCategoryTabs({
    super.key,
    required this.tabs,
    required this.controller,
    this.height = 36,
    this.gap = 10,
  });

  final List<String> tabs;
  final TabController controller;
  final double height;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final selected = controller.index;

        return SizedBox(
          height: height.h,
          child: Row(
            children: List.generate(tabs.length, (i) {
              final isSelected = i == selected;

              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: i == tabs.length - 1 ? 0 : gap.w,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () => controller.animateTo(i),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.turnbullBlue
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : AppColors.lightSilver,
                        ),
                      ),
                      child: Text(
                        tabs[i],
                        style: AppTextStyles.title.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.strongGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}