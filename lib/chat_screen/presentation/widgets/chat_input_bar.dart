import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 72.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          /// SEND
          IconButton(
            icon: Icon(
              Icons.send,
              size: 22.sp,
              color: AppColors.turnbullBlue,
            ),
            onPressed: () {},
          ),

          /// DIVIDER
          Container(
            width: 1.w,
            height: 28.h,
            color: AppColors.spanishGrey.withOpacity(0.4),
          ),

          /// CAMERA
          IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () {},
          ),

          /// MICROPHONE
          IconButton(
            icon: Icon(
              Icons.mic_none_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () {},
          ),

          /// LOCATION
          IconButton(
            icon: Icon(
              Icons.location_on_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () {},
          ),

          /// INPUT FIELD
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: context.l10n.writeYourMessageHere,
                hintStyle: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}