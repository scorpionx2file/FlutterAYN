import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import '../../../../core/theme/fonts/app_text_styles.dart';

class BottomSectionTabs extends StatefulWidget {
  const BottomSectionTabs({super.key});

  @override
  State<BottomSectionTabs> createState() => _BottomSectionTabsState();
}

class _BottomSectionTabsState extends State<BottomSectionTabs> {
  int selectedIndex = 0;
  final double startOffset = 5;


  final List<String> tabs = [
    "Posts",
    "Activities",
    "Services ",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ===== TABS =====
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Text(
                tabs[index],
                style: AppTextStyles.text.copyWith(
                  color: isSelected ? AppColors.turnbullBlue : AppColors.spanishGrey,
                  fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            );
          }),
        ),

         SizedBox(height: 8.h),

        // ===== LINE SYSTEM =====
        LayoutBuilder(
          builder: (context, constraints) {
            final tabWidth = constraints.maxWidth / tabs.length;

            return Stack(
              children: [
                // ---- Gray full line ----
                Container(
                  height: 2.h,
                  width: double.infinity,
                  color: AppColors.lightSilver,
                ),

                // ---- Active colored line ----
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  left: tabWidth * selectedIndex - startOffset,
                  child: Container(
                    height: 2.h,
                    width: tabWidth,
                    color: AppColors.turnbullBlue,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
