import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class TermsPrivacyScreen extends StatefulWidget {
  const TermsPrivacyScreen({super.key});

  @override
  State<TermsPrivacyScreen> createState() => _TermsPrivacyScreenState();
}

class _TermsPrivacyScreenState extends State<TermsPrivacyScreen> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: AppColors.black),
        ),
        title: Text(
          l10n.termsPrivacyTitle,
          style: AppTextStyles.headingH3.copyWith(color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),

            // Logo (use your real asset)
            Center(
              child: Image.asset(
                "assets/images/icons/logo.png",
                width: 90.w,
                height: 90.w,
              ),
            ),

            SizedBox(height: 12.h),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _dummyTerms,
                  style: AppTextStyles.text.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            Row(
              children: [
                Checkbox(
                  value: accepted,
                  onChanged: (v) => setState(() => accepted = v ?? false),
                ),
                Expanded(
                  child: Text(
                    l10n.acceptTermsLabel,
                    style: AppTextStyles.description.copyWith(
                      color: AppColors.spanishGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

const String _dummyTerms =
    "This is a sample Terms of Use & Privacy Policy text.\n\n"
    "1) Usage\n"
    "By using the app, you agree to follow the rules and respect other users.\n\n"
    "2) Privacy\n"
    "We collect only the data necessary to provide the service.\n\n"
    "3) Content\n"
    "You are responsible for the content you post.\n\n"
    "4) Updates\n"
    "We may update these terms from time to time.";