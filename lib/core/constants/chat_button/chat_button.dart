import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';

class ChatButton extends StatelessWidget{
  final VoidCallback onTap;

  const ChatButton({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 120.w,
          maxWidth: 160.w,
          minHeight: 47.h,
          maxHeight: 47.h
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom().copyWith(
          backgroundColor: WidgetStateProperty.all(AppColors.darkYellow),
          foregroundColor: WidgetStateProperty.all(AppColors.black),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          )),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)),
        ),
        onPressed: onTap,
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/icons/chat.png",
                  color: AppColors.black,
                    width: 18.w,
                    height: 18.h
                ),
                SizedBox(width: 5.w),
                Text(
                    "Chat",
                  style: AppTextStyles.button,
                )
              ],
            )
      ),
      )
    );
  }
}