import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class PackageCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String? points;
  final Color titleColor;
  final bool isSelected;

  const PackageCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.titleColor,
    this.points,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          /// Main Card
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected
                    ? AppColors.turnbullBlue
                    : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Row(
              children: [

                /// Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.text.copyWith(
                          color: titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        description,
                        style: AppTextStyles.description.copyWith(
                          color: AppColors.strongGrey,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 16.w),

                /// Divider
                Container(
                  width: 1.w,
                  height: 50.h,
                  color: AppColors.spanishGrey,
                ),

                SizedBox(width: 16.w),

                /// Price Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$price SAR",
                          style: AppTextStyles.text.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "/Month",
                          style: AppTextStyles.description.copyWith(
                            color: AppColors.strongGrey,
                          ),
                        ),
                      ],
                    ),
                    if (points != null) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            size: 12.sp,
                            color: AppColors.lebaneseRed,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "$points Point",
                            style: AppTextStyles.description.copyWith(
                              color: AppColors.lebaneseRed,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          /// Check icon on top-left corner
          if (isSelected)
            Positioned(
              top: -8.h,
              left: -8.w,
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: AppColors.turnbullBlue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.turnbullBlue.withOpacity(0.4),
                      blurRadius: 6,
                    )
                  ],
                ),
                child: Icon(
                  Icons.check,
                  size: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
