import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/post_service_provider_header/post_or_service_provider_header.dart';
import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';

class HeaderUserInfo extends StatelessWidget {
  final PostHeaderData data;
  final bool isHighlighted;

  const HeaderUserInfo({
    super.key,
    required this.data,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.username,
          style: AppTextStyles.text.copyWith(
            color: isHighlighted ? AppColors.white : AppColors.black
          ),
        ),

        SizedBox(height: 4.h),

        Row(
          children: [
            Text(
              data.jobOrLocation,
              style: AppTextStyles.description.copyWith(
                  color: isHighlighted ? AppColors.white : AppColors.spanishGrey
              ),
            ),

            if (data.rate != null) ...[
              SizedBox(width: 5.w),
              Icon(Icons.star, color: AppColors.darkYellow, size: 14.r),
              SizedBox(width: 2.w),
              Text(
                data.rate!.toString(),
                style: AppTextStyles.description.copyWith(
                  color: AppColors.darkYellow
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}