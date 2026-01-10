import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 52,
    this.width,
    this.horizontalPadding = 18,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.borderRadius = 12,
  });

  final String text;
  final VoidCallback? onPressed;

  final double height;
  final double? width;
  final double horizontalPadding;

  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).elevatedButtonTheme.style;

    final h = height.h;
    final w = width?.w;
    final padX = horizontalPadding.w;
    final r = borderRadius.r;

    final style = (themeStyle ?? const ButtonStyle()).merge(
      ElevatedButton.styleFrom(
        minimumSize: Size(w ?? double.infinity, h),
        padding: EdgeInsets.symmetric(horizontal: padX),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(r),
        ),
        elevation: elevation,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: textStyle,
      ),
    );

    return SizedBox(
      height: h,
      width: w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
