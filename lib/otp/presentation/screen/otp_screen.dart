import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../core/constants/auth/auth_screen_bg.dart';
import '../../../core/constants/button/app_button.dart';
import '../widgets/otp_pin_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScreenBg(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Text(
            'Verify your phone number',
            textAlign: TextAlign.center,
            style: AppTextStyles.headingH2.copyWith(
              color: AppColors.black,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter the verification code we sent to your phone.',
            textAlign: TextAlign.center,
            style: AppTextStyles.text.copyWith(
              color: AppColors.spanishGrey,
              height: 1.4,
            ),
          ),

          SizedBox(height: 46.h),

          const OtpPinField(
            length: 4,
            activeUnderlineColor: AppColors.turnbullBlue,
            inactiveUnderlineColor: AppColors.lightSilver,
          ),

          SizedBox(height: 120.h),

          AppButton(
            text: 'Verify',
            onPressed: () {},
            backgroundColor: AppColors.lightGreen,
            height: 36.h,

          ),

          SizedBox(height: 38.h),

          Text(
            'Didn’t receive the code?',
            style: AppTextStyles.description.copyWith(
              color: AppColors.spanishGrey,
            ),
          ),
          SizedBox(height: 6.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, size: 16.sp, color: AppColors.strongGrey),
              SizedBox(width: 6.w),
              Text(
                'Resend code',
                style: AppTextStyles.description.copyWith(
                  color: AppColors.strongGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}
