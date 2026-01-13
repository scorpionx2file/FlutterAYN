import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

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

  final List<OnboardingSlideData> _slides = const [
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_one.png',
      title: 'Share your journey with everyone',
      subtitle: 'Post your moments and let others follow your travel story.',
    ),
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_two.png',
      title: 'Find the nearest tourist places around you',
      subtitle: 'Discover top spots nearby with a simple and fast experience.',
    ),
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_three.png',
      title: 'Offer your tourism services easily',
      subtitle: 'List and manage your services in a few quick steps.',
    ),
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_four.png',
      title: 'A market for all tourism activities',
      subtitle: 'Explore activities, attractions, and great experiences.',
    ),
    OnboardingSlideData(
      imageAsset: 'assets/images/onboarding_five.png',
      title: 'Meet new friends near you',
      subtitle: 'Connect with travelers and build new experiences together.',
    ),
  ];

  bool get _isLast => _index == _slides.length - 1;

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
    if (_isLast) return;
    _controller.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonText = _isLast ? 'Get Started' : 'Next';

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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Skip',
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
                    itemCount: _slides.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (_, i) => OnboardingSlide(
                      data: _slides[i],
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

                OnboardingDots(count: _slides.length, index: _index),

                SizedBox(height: 28.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
