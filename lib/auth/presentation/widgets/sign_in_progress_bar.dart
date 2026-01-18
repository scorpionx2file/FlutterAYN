import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class SignInProgressBar extends StatelessWidget {
  const SignInProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.progressValue,
    this.onBack,
  });

  final int currentStep;
  final int totalSteps;

  final double? progressValue;

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final fallback = (currentStep / totalSteps).clamp(0.0, 1.0);
    final progress = (progressValue ?? fallback).clamp(0.0, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "$currentStep/$totalSteps",
                style: TextStyle(fontSize: 12.sp, color: AppColors.black),
              ),
              const Spacer(),
              IconButton(
                onPressed: onBack,
                icon: Icon(
                  Icons.arrow_forward,
                  size: 22.sp,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: SizedBox(
              height: 3.h,
              width: double.infinity,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.lightSilver,
                valueColor: AlwaysStoppedAnimation(AppColors.turnbullBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
