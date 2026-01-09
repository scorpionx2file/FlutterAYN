import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';
import '../category_badge/category_badge.dart';

class Activity {
  final String imageUrl;
  final String title;
  final String category;
  final String time;

  Activity({
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.time,
  });
}

class ActivityCard extends StatelessWidget{
  final String imageUrl;
  final String activityTitle;
  final String activityCategory;
  final String activityTime;
  final bool isYellow;

  const ActivityCard({
    super.key,
    required this.imageUrl,
    required this.activityTitle,
    required this.activityCategory,
    required this.activityTime,
    required this.isYellow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
            children: [
              Positioned.fill(
                  child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover
                  )
              ),

              Positioned.fill(
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColors.black.withValues(alpha: 0.6),
                                Colors.transparent,
                              ]
                          )
                      )
                  )
              ),

              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                          activityTitle,
                          style: AppTextStyles.titles.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      SizedBox(height: 5.h),
                      Row(
                          children: [
                            Image.asset(
                                "assets/images/icons/calender.png",
                                color: Colors.white,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                                activityTime,
                                style: AppTextStyles.text.copyWith(
                                    color: Colors.white
                                )
                            ),
                          ]
                      ),
                      SizedBox(height: 6.h),
                      CategoryBadge(
                          label: activityCategory,
                          isYellow: isYellow
                      )
                    ]
                ),
              )
            ]
        ),
      ),
    );
  }
}