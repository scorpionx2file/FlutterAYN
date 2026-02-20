import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class TextArea extends StatelessWidget {
  final String hintText;
  final double height;
  final TextEditingController? controller;
  final bool showError;
  final String? errorText;

  const TextArea({
    super.key,
    required this.hintText,
    required this.height,
    this.controller,
    this.showError = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: height,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: showError
                  ? Border.all(color: AppColors.lebaneseRed, width: 1.5)
                  : null,
            ),
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          if (showError && errorText != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h, left: 4.w),
              child: Text(
                errorText!,
                style: TextStyle(
                  color: AppColors.lebaneseRed,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}