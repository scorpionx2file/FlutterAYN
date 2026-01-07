import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';

class HeaderMeta extends StatelessWidget {
  final String? title;
  final String? date;

  const HeaderMeta({
    super.key,
    this.title,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null)
            Text(
              title!,
              style: AppTextStyles.button,
            ),

          if (date != null)
            Text(
              date!,
              style: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey
              ),
            ),
        ],
      ),
    );
  }
}
