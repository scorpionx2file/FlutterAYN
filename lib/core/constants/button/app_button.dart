import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconSpacing = 6,
    this.height = 52,
    this.width,
    this.horizontalPadding = 18,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.borderRadius = 12,
    this.borderSide,
  });

  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final double height;
  final double? width;
  final double horizontalPadding;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final BorderSide? borderSide;
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    // Apply ScreenUtil to all numeric values
    final h = height.h;
    final w = width?.w;
    final padX = horizontalPadding.w;
    final r = borderRadius.r;
    final spacing = iconSpacing.w;

    // Build child with optional icon
    final child = icon != null
        ? Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon!,
        SizedBox(width: spacing),
        Text(
          text,
          style: textStyle?.copyWith(
            fontSize: textStyle?.fontSize?.sp,
          ),
        ),
      ],
    )
        : Text(
      text,
      style: textStyle?.copyWith(
        fontSize: textStyle?.fontSize?.sp,
      ),
    );

    // OUTLINED STATE
    if (borderSide != null) {
      return SizedBox(
        height: h,
        width: w,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: borderSide,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: padX),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(r),
            ),
            textStyle: textStyle?.copyWith(
              fontSize: textStyle?.fontSize?.sp,
            ),
          ),
          child: child,
        ),
      );
    }

    // FILLED STATE
    return SizedBox(
      height: h,
      width: w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: EdgeInsets.symmetric(horizontal: padX),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r),
          ),
          textStyle: textStyle?.copyWith(
            fontSize: textStyle?.fontSize?.sp,
          ),
        ),
        child: child,
      ),
    );
  }
}
