import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/fonts/app_text_styles.dart';

class StoryHeader extends StatelessWidget{
  final String imageUrl;
  final String username;
  final String location;

  const StoryHeader({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(width: 5.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: AppTextStyles.text.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: AppColors.white,
                    size: 10.sp
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    location,
                    style: AppTextStyles.description.copyWith(
                      color: AppColors.white
                    ),
                  )
                ]
              )
            ]
          ),

          Spacer(),
          Icon(
            Icons.more_horiz,
            color: AppColors.white,
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: AppColors.black,
              size: 20.sp,
            ),
          )
        ],
      ),
    );
  }
}