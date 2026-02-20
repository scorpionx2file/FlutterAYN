import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class EventData extends StatelessWidget{
  final String title;
  final String icon;
  final Widget child;
  final List<Widget>? trailing;
  final bool showError;

  const EventData({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
    this.showError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titles,
        ),
        SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
                border: showError
                    ? Border.all(color: AppColors.lebaneseRed, width: 1.5)
                    : null,
              ),
              child: Row(
                children: [
                  Image.asset(
                    icon,
                    width: 20.w,
                    height: 20.h,
                    color: AppColors.turnbullBlue,
                  ),

                  SizedBox(width: 10.w),

                  Expanded(child: child),

                  if(trailing != null)... trailing!
                ],
              ),
            ),
        if (showError)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 8.w),
            child: Text(
              "Field required",
              style: TextStyle(
                color: AppColors.lebaneseRed,
                fontSize: 12.sp,
              ),
            ),
          ),
      ],
    );
  }
}