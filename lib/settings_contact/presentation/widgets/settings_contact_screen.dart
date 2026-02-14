import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/profile_settings/profile_settings_header.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../core/constants/text_area/text_area.dart';

class SettingsContactScreen extends StatelessWidget {
  const SettingsContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.settings,
          style: AppTextStyles.titles.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w,vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 30.r,
                    color: AppColors.turnbullBlue,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    context.l10n.contactTechnicalSupport,
                    style: AppTextStyles.titles.copyWith(
                      color: AppColors.turnbullBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              ProfileSettingsHeader(
                name: "Adham Mohamed",
                username: "adhambiko",
                profileImage: AssetImage("assets/images/profile.png"),
                isProfileSettings: false,
                isVerified: true,
                onBackPressed: () {},
                onEditPressed: () {},
              ),

              SizedBox(height: 16.h),

              Text(
                context.l10n.mobileNumber,
                style: AppTextStyles.titles.copyWith(
                  color: AppColors.turnbullBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 4.h),

              AppTextFields(controller: TextEditingController(text: "Enter Your Number ...")),

              SizedBox(height: 8.h),

              Text(
                context.l10n.yourMessage,
                style: AppTextStyles.titles.copyWith(
                  color: AppColors.turnbullBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 4.h),

              TextArea(
                  hintText: context.l10n.enterYourMessageHint,
                height: 200.h,
              ),

              SizedBox(height: 24.h),

              AppButton(
                text: context.l10n.send,
                onPressed: () {},
                height: 32.h,
                width: 290.w,
                backgroundColor: AppColors.lebaneseRed,
                foregroundColor: AppColors.white,
              ),
            ],
          ),
        ),
    );
  }
}
