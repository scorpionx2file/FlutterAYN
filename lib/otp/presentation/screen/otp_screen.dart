import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../core/constants/auth/auth_screen_bg.dart';
import '../../../core/constants/button/app_button.dart';
import '../widgets/otp_pin_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _code = '';
  String? _error;
  bool _submitted = false;

  void _validateAndGo() {
    setState(() => _submitted = true);
    FocusScope.of(context).unfocus();

    if (_code.trim().length != 4) {
      setState(() => _error = context.l10n.otpRequired);
      return;
    }

    setState(() => _error = null);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenBg(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Text(
            context.l10n.verifyPhoneNumber,
            textAlign: TextAlign.center,
            style: AppTextStyles.headingH2.copyWith(
              color: AppColors.black,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.enterVerificationCode,
            textAlign: TextAlign.center,
            style: AppTextStyles.text.copyWith(
              color: AppColors.spanishGrey,
              height: 1.4,
            ),
          ),
          SizedBox(height: 46.h),

          OtpPinField(
            length: 4,
            activeUnderlineColor: AppColors.turnbullBlue,
            inactiveUnderlineColor: AppColors.lightSilver,
            errorText: _submitted ? _error : null,
            onChanged: (v) {
              setState(() {
                _code = v;
                if (_submitted) {
                  _error = (v.trim().length == 4) ? null : context.l10n.otpRequired;
                }
              });
            },
            onCompleted: (v) {
              setState(() {
                _code = v;
                _error = null;
              });
            },
          ),

          SizedBox(height: 120.h),

          AppButton(
            text: context.l10n.verify,
            onPressed: _validateAndGo,
            backgroundColor: AppColors.lightGreen,
            height: 36.h,
          ),

          SizedBox(height: 38.h),

          Text(
            context.l10n.didntReceiveCode,
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
                context.l10n.resendCode,
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
