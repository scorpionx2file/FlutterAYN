import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/category_badge/category_badge.dart';
import '../../../theme/colors/app_colors.dart';
import '../../../theme/fonts/app_text_styles.dart';

class EventActivitiesData{
  final String imageUrl;
  final String title;
  final String date;
  final String category;

  const EventActivitiesData({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.category,
  });
}

class EventOptionsActivities extends StatelessWidget {
  final EventActivitiesData data;

  const EventOptionsActivities({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95.h,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                data.imageUrl,
                width: 120.w,
                height: 100.h,
                fit: BoxFit.cover,
              )
            ),

            SizedBox(width: 12.w,),

            Expanded(
              child: _ActivityInfo(
                title: data.title,
                date: data.date,
                category: data.category
              )
            ),

            SizedBox(width: 5.w,),

            Image.asset(
              'assets/images/icons/suitcase.png',
              width: 24.w,
              height: 24.h,
              color: AppColors.spanishGrey,
            )
          ]
        )
      )
    );
  }
}

class _ActivityInfo extends StatelessWidget{
  final String title;
  final String date;
  final String category;

  const _ActivityInfo({
    super.key,
    required this.title,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.text.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Image.asset(
              'assets/images/icons/calender.png',
              width: 12,
              height: 12,
              color: AppColors.black,
            ),
            SizedBox(width: 5.w),
            Text(
              date,
              style: AppTextStyles.description,
            )
          ],
        ),

        SizedBox(height: 5.h),

        CategoryBadge(
            label: category,
            isYellow: false,
        )
      ],
    );
  }
}