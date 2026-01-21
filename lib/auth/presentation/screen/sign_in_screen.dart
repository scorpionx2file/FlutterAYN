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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoMode = AutovalidateMode.disabled;

  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();
    setState(() => _autoMode = AutovalidateMode.onUserInteraction);

    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenBg(
      bottom: Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          context.l10n.registerTerms,
          textAlign: TextAlign.center,
          style: AppTextStyles.description.copyWith(color: AppColors.spanishGrey),
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
                  context.l10n.registerTitle,
                  style: AppTextStyles.title.copyWith(color: AppColors.black),
                ),
                SizedBox(height: 6.h),
                Text(
                  context.l10n.registerSubtitle,
                  style: AppTextStyles.description.copyWith(
                    color: AppColors.spanishGrey,
                  ),
                ),
                SizedBox(height: 18.h),

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
                  validator: (v) => AuthValidators.email(context, v),
                ),

                SizedBox(height: 14.h),

                Text(
                  context.l10n.passwordLabel,
                  style: AppTextStyles.text.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                AppTextFields(
                  controller: passCtrl,
                  hintText: context.l10n.passwordHint,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (v) => AuthValidators.password(context, v),
                ),

                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.forgetPassword),
                      child: Text(
                        context.l10n.forgetPasswordLink,
                        style: AppTextStyles.description.copyWith(
                          color: AppColors.strongGrey,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 38.h),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: context.l10n.login,
                    onPressed: _login,
                    height: 36.h,
                    backgroundColor: AppColors.turnbullBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
