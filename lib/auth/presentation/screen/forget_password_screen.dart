import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/constants/auth/auth_screen_bg.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenBg(
      bottom: SizedBox(
        width: double.infinity,
        child: AppButton(
          text: context.l10n.send,
          onPressed: () => context.go(AppRoutes.otp),
          height: 36.h,
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.forgetPasswordTitle,
              style: AppTextStyles.title.copyWith(color: AppColors.black),
            ),
            SizedBox(height: 4.h),
            Text(
              context.l10n.forgetPasswordDesc,
              style: AppTextStyles.text.copyWith(color: AppColors.spanishGrey),
            ),
            SizedBox(height: 64.h),
            Text(
              context.l10n.emailAddressLabel,
              style: AppTextStyles.text.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            AppTextFields(
              controller: emailCtrl,
              hintText: context.l10n.emailAddressHint,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
