import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class EventData extends StatelessWidget{
  final String title;
  final String icon;
  final Widget child;
  final List<Widget>? trailing;

  const EventData({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
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
            color: AppColors.white
          ),
          child: Row(
            children: [
              Image.asset(
                icon,
                width: 20.w,
                height: 20.h,
              ),

              SizedBox(width: 10.w),

              Expanded(child: child),

              if(trailing != null)... trailing!
            ],
          ),
        )
      ],
    );
  }
}