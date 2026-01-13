import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/event_option/presentation/widgets/content_section/temp_section.dart';

class InfoRow extends StatelessWidget{
  final int postsNum;
  final int maxTemp;
  final int minTemp;

  const InfoRow({
    super.key, required this.postsNum, required this.maxTemp, required this.minTemp
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Posts $postsNum",
          style: AppTextStyles.text.copyWith(
            color:AppColors.white
          ),
        ),
        SizedBox(width: 140.w),
        Container(
          height: 25.h,
          width: 25.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child:Center(
            child: Icon(
                Icons.favorite,
                color: AppColors.lebaneseRed,
                size: 18.sp
              ),
          ),
          ),
        SizedBox(width: 10.w),

        TempSection(
          maxTemp: maxTemp,
          minTemp: minTemp,
        )
      ],
    );
  }


}