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

  const PackageCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.titleColor, this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [

            /// Right Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titles.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
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

            /// Vertical Divider
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
                      "${price}SAR",
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
                      Text(
                        "${points!}Point",
                        style: AppTextStyles.description.copyWith(
                          color: AppColors.lebaneseRed,
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
                ],
              ],
            ),

            SizedBox(width: 12.w),

            /// Arrow Icon (left side)
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18.sp,
              color: Colors.grey,
            ),

          ],
        ),
      ),
    );
  }
}



class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            PackageCard(
              title: "Free Trial",
              description:
              "Enjoy a free trial period, then choose the package that suits you best.",
              price: "650",
             // points: "180",
              titleColor: AppColors.moderateBlue,
            ),
          ],
        ),
      ),
    );
  }
}
