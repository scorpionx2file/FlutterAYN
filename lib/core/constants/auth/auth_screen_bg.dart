import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class AuthScreenBg extends StatelessWidget {
  const AuthScreenBg({
    super.key,
    required this.child,
    this.bottom,
    this.sheetPadding = const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    this.showHandle = true,
  });

  final Widget child;
  final Widget? bottom;
  final EdgeInsets sheetPadding;
  final bool showHandle;

  @override
  Widget build(BuildContext context) {
    final padding = sheetPadding.copyWith(
      left: sheetPadding.left.w,
      right: sheetPadding.right.w,
      top: sheetPadding.top.h,
      bottom: sheetPadding.bottom.h,
    );

    final keyboard = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColors.lightSilver,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: padding.copyWith(
                        bottom: bottom == null ? padding.bottom : (padding.bottom + 80.h),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showHandle) ...[
                            Center(
                              child: Container(
                                width: 70.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color: AppColors.lightSilver,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            SizedBox(height: 18.h),
                          ],
                          Center(child: Image.asset("assets/images/icons/logo.png", height: 98.h)),
                          SizedBox(height: 22.h),
                          child,
                        ],
                      ),
                    ),
                    if (bottom != null)
                      Positioned(
                        left: padding.left,
                        right: padding.right,
                        bottom: math.max(12.h, keyboard + 12.h),
                        child: bottom!,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
