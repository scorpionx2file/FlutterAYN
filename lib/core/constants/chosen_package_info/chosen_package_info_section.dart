import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';

class ChosenPackageInfoSection extends StatelessWidget {
  final int packagePrices ;
  final String packageTitle;

  const ChosenPackageInfoSection({super.key, required this.packagePrices, required this.packageTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 18.w,vertical: 4.h),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total",
                style: AppTextStyles.titles,
              ),
              Text(
                packageTitle,
                style: AppTextStyles.text
                    .copyWith(
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            "$packagePrices SAR",
            style: AppTextStyles.text
                .copyWith(
              fontWeight:
              FontWeight.bold,
              color: AppColors
                  .turnbullBlue,
            ),
          ),
        ],
      ),
    );
  }
}
