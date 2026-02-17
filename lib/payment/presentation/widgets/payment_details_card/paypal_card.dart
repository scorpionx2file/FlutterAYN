import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class PayPalCard extends StatelessWidget {
  final String email;
  final String addedDate;

  const PayPalCard({
    super.key,
    required this.email,
    required this.addedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/payPal.png",
                    scale: 0.8,
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: (){},
                  ),

                ],
              ),

               SizedBox(height: 24.h),

              Text(
                "Name on Card",
                style: AppTextStyles.text
                    .copyWith(color: Colors.grey),
              ),

               SizedBox(height: 8.h),

              Text(
                email,
                style: AppTextStyles.headingH4,
              ),

               SizedBox(height: 16.h),

              Text(
                "Added on $addedDate",
                style: AppTextStyles.text
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
