import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../core/utils/validators/auth_validators.dart';
import '../widgets/sign_in_progress_bar.dart';
import '../widgets/social_icon_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;

  AutovalidateMode _autoMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _autoMode = AutovalidateMode.onUserInteraction);

    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 12.h),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              text: context.l10n.next,
              onPressed: _submit,
              height: 38.h,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SignInProgressBar(
              currentStep: 2,
              totalSteps: 3,
              progressValue: 2 / 3,
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18.h),
                      Text(
                        context.l10n.signUpAccountInfoTitle,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 22.h),

                      Text(
                        context.l10n.fullNameLabel,
                        style: AppTextStyles.text.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      AppTextFields(
                        controller: nameCtrl,
                        hintText: context.l10n.fullNameHint,
                        keyboardType: TextInputType.name,
                        validator: (v) => AuthValidators.name(context, v),
                      ),

                      SizedBox(height: 14.h),

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
                        hintText: context.l10n.emailAddressHintExample,
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

                      SizedBox(height: 28.h),

                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialIconButton(
                              onTap: () {},
                              backgroundColor: AppColors.black,
                              child: Icon(Icons.apple, color: AppColors.white, size: 18.sp),
                            ),

                            SizedBox(width: 14.w),

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

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
