import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/constants/auth/auth_screen_bg.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import 'package:traveller/core/utils/validators/auth_validators.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoMode = AutovalidateMode.disabled;

  late final TextEditingController emailCtrl;

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  void _send() {
    FocusScope.of(context).unfocus();
    setState(() => _autoMode = AutovalidateMode.onUserInteraction);

    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    context.go(AppRoutes.otp);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenBg(
      bottom: SizedBox(
        width: double.infinity,
        child: AppButton(
          text: context.l10n.send,
          onPressed: _send,
          height: 36.h,
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autoMode,
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
                  style:
                  AppTextStyles.text.copyWith(color: AppColors.spanishGrey),
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
                  validator: (v) => AuthValidators.email(context, v),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
