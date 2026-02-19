import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/constants/auth/auth_screen_bg.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import 'package:traveller/auth/presentation/widgets/social_icon_button.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AuthScreenBg(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 26.h),

          Text(
            l10n.registerTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.title.copyWith(color: AppColors.black),
          ),

          SizedBox(height: 24.h),

          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: l10n.signUp,
              onPressed: () => context.go("${AppRoutes.chooseGates}?isRegister=true"),
              height: 36.h,
              backgroundColor: AppColors.turnbullBlue,
            ),
          ),

          SizedBox(height: 22.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.alreadyHaveAccount,
                style: AppTextStyles.description.copyWith(color: AppColors.spanishGrey),
              ),
              GestureDetector(
                onTap: () => context.go(AppRoutes.login),
                child: Text(
                  l10n.signIn,
                  style: AppTextStyles.description.copyWith(
                    color: AppColors.spanishGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 240.h),

          Text(
            l10n.registerTerms,
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
