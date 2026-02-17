import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import 'checkbox_pill.dart';

class BagListTile extends StatelessWidget {
  const BagListTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.text.copyWith(
                  color: AppColors.strongGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CheckBoxPill(selected: selected),
          ],
        ),
      ),
    );
  }
}