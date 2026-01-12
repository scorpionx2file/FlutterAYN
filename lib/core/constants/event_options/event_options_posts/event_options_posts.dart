import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import '../../../theme/fonts/app_text_styles.dart';

class EventPostsData{
  final String imageUrl;
  final String username;
  final String title;
  final String date;
  final String postImage;
  final double rate;

  const EventPostsData({
    required this.imageUrl,
    required this.username,
    required this.title,
    required this.date,
    required this.postImage,
    required this.rate,
  });
}

class EventOptionsPosts extends StatelessWidget {
  final EventPostsData data;

  const EventOptionsPosts({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95.h,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  data.postImage,
                  width: 120.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                )
              ),

                const Icon(
                  Icons.play_circle_fill,
                  color: AppColors.white,
                  size: 56,
                )
              ],
            ),

            SizedBox(width: 12.w,),

            Expanded(
              child: _PostInfo(
                imageUrl: data.imageUrl,
                username: data.username,
                title: data.title,
                date: data.date
              ),
            ),

            SizedBox(width: 10.w,),

            Icon(Icons.star, color: AppColors.darkYellow, size: 14.r),
            SizedBox(height: 2.h),
            Text(
              data.rate.toString(),
              style: AppTextStyles.description.copyWith(
                  color: AppColors.darkYellow
            ),
            )
          ]
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String imageUrl;
  final String username;

  const _UserInfo({
    super.key,
    required this.imageUrl,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12.r,
          backgroundImage: NetworkImage(imageUrl),
        ),

        SizedBox(width: 5.w),

        Text(
          username,
          style: AppTextStyles.description.copyWith(
            color: AppColors.spanishGrey
          )
        )
      ]
    );
  }
}

class _PostInfo extends StatelessWidget{
  final String imageUrl;
  final String username;
  final String title;
  final String date;

  const _PostInfo({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UserInfo(
          imageUrl: imageUrl,
          username: username,
        ),

        SizedBox(height: 10.h),

        Text(
          title,
          style: AppTextStyles.text.copyWith(
            fontWeight: FontWeight.bold
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis
        ),

        SizedBox(height: 5.h),

        Text(
          date,
          style: AppTextStyles.description.copyWith(
            color: AppColors.spanishGrey
          )
        )
      ]
    );
  }
}