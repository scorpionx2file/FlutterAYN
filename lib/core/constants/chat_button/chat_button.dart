import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class ChatButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? backgroundColor; // optional

  const ChatButton({
    super.key,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Decide foreground color based on background
    final Color bg = backgroundColor ?? AppColors.darkYellow;
    final Color fg = bg == AppColors.turnbullBlue ? Colors.white : AppColors.black;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 122.w,
        maxWidth: 160.w,
        minHeight: 36.h,
        maxHeight: 47.h,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom().copyWith(
          backgroundColor: MaterialStateProperty.all(bg),
          foregroundColor: MaterialStateProperty.all(fg),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ),
        onPressed: onTap,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/icons/chat.png",
                color: fg, // set icon color dynamically
                width: 18.w,
                height: 18.h,
              ),
              SizedBox(width: 5.w),
              Text(
                context.l10n.chat,
                style: AppTextStyles.button.copyWith(color: fg), // dynamic text color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
