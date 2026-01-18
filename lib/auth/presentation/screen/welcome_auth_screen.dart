import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/auth/presentation/screen/choose_gates_screen.dart';
import 'package:traveller/auth/presentation/widgets/social_icon_button.dart';
import 'package:traveller/core/constants/auth/auth_screen_bg.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScreenBg(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 26.h),

          Text(
            "Welcome to our community!",
            textAlign: TextAlign.center,
            style: AppTextStyles.title.copyWith(color: AppColors.black),
          ),

          SizedBox(height: 24.h),

          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: "Continue with Mobile Number",
              onPressed: () {},
              height: 36.h,
              backgroundColor: AppColors.turnbullBlue,
            ),
          ),

          SizedBox(height: 18.h),

          Align(
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                SocialIconButton(
                  onTap: () {},
                  backgroundColor: AppColors.black,
                  child: Icon(Icons.apple, color: AppColors.white, size: 18.sp),
                ),
                SizedBox(height: 12.h),
                SocialIconButton(
                  onTap: () {},
                  backgroundColor: AppColors.neonCoral,
                  child: Image.asset(
                    "assets/images/icons/google.png",
                    color: AppColors.white,
                    width: 18.sp,
                    height: 18.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 22.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ChooseGatesScreen()),
                  );
                },
                child: Text(
                  "Sign in",
                  style: AppTextStyles.description.copyWith(
                    color: AppColors.spanishGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 120.h),

          Text(
            "By continuing, you agree to our Terms & Conditions and Privacy Policy.",
            textAlign: TextAlign.center,
            style: AppTextStyles.description.copyWith(
              color: AppColors.spanishGrey,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
