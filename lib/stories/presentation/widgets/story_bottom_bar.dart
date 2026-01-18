import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class StoryBottomBar extends StatelessWidget {
  const StoryBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/icons/write.png",
                    color: AppColors.black,
                    height: 20.h,
                    width: 20.w,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: l10n.storySendMessageHint,
                        hintStyle: AppTextStyles.description.copyWith(
                          color: AppColors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    backgroundColor: AppColors.lebaneseRed,
                    child: Image.asset(
                      "assets/images/icons/suitcase.png",
                      width: 20.w,
                      height: 20.h,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
