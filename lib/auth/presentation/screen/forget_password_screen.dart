import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/auth/auth_screen_bg.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/fonts/app_text_styles.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
   final emailCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AuthScreenBg(
      bottom: SizedBox(
        width: double.infinity,
        child: AppButton(text: "Send", onPressed: () {}, height: 36.h),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Forget Password ?', style: AppTextStyles.title.copyWith(color: AppColors.black)),
            SizedBox(height: 4.h),
            Text(
              'Please enter your email address to receive a link to create a new password via email.',
              style: AppTextStyles.text.copyWith(color: AppColors.spanishGrey),
            ),
            SizedBox(height: 64.h),
            Text(
              "Email Address",
              style: AppTextStyles.text.copyWith(color: AppColors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6.h),
            AppTextFields(
              controller: emailCtrl,
              hintText: "Enter your email address",
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );

  }
}
