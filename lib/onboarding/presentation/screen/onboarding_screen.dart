import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../core/constants/button/app_button.dart';
import '../../../core/constants/onboarding/onboarding_slide_data.dart';
import '../widgets/onboarding_dots.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;
  int _index = 0;

  List<OnboardingSlideData> _slides(BuildContext context) => [
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_one.png',
      title: context.l10n.onboardingTitle1,
      subtitle: context.l10n.onboardingSubtitle1,
    ),
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_two.png',
      title: context.l10n.onboardingTitle2,
      subtitle: context.l10n.onboardingSubtitle2,
    ),
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_three.png',
      title: context.l10n.onboardingTitle3,
      subtitle: context.l10n.onboardingSubtitle3,
    ),
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_four.png',
      title: context.l10n.onboardingTitle4,
      subtitle: context.l10n.onboardingSubtitle4,
    ),
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_five.png',
      title: context.l10n.onboardingTitle5,
      subtitle: context.l10n.onboardingSubtitle5,
    ),
  ];

  bool get _isLast => _index == 4; // 5 slides (0..4)

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLast) {
      context.go(AppRoutes.welcome);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final slides = _slides(context);
    final buttonText = _isLast ? context.l10n.getStarted : context.l10n.next;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/onboarding_bg.png",
              width: 1.sw,
              height: 0.42.sh,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => context.go(AppRoutes.welcome),
                        child: Text(
                          context.l10n.skip,
                          style: AppTextStyles.titles.copyWith(
                            color: AppColors.strongGrey,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Image.asset("assets/images/icons/logo.png", height: 36.h),
                      const Spacer(),
                      SizedBox(width: 40.w),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: slides.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (_, i) => OnboardingSlide(
                      data: slides[i],
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AppButton(
                    text: buttonText,
                    onPressed: _next,
                    height: 36.h,
                  ),
                ),
                SizedBox(height: 18.h),
                OnboardingDots(count: slides.length, index: _index),
                SizedBox(height: 28.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
