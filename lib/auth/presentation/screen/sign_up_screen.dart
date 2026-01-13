import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/auth/auth_screen_bg.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return AuthScreenBg(
      bottom: Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          "By signing up, you agree to our Terms & Conditions and Privacy Policy.",
          textAlign: TextAlign.center,
          style: AppTextStyles.description.copyWith(color: AppColors.spanishGrey),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Our Community!",
              style: AppTextStyles.title.copyWith(color: AppColors.black),
            ),
            SizedBox(height: 6.h),
            Text(
              "Create an account to get started",
              style: AppTextStyles.description.copyWith(color: AppColors.spanishGrey),
            ),
            SizedBox(height: 18.h),

            Text(
              "Email Address",
              style: AppTextStyles.text.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            AppTextFields(
              controller: emailCtrl,
              hintText: "Enter your email address",
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 14.h),

            Text(
              "Password",
              style: AppTextStyles.text.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            AppTextFields(
              controller: passCtrl,
              hintText: "Enter your password",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),

            SizedBox(height: 38.h),

            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: "Sign Up",
                onPressed: () {},
                height: 36.h,
                backgroundColor: AppColors.turnbullBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
