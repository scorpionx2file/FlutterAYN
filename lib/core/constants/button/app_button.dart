import 'package:flutter/material.dart';

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

    final style = (themeStyle ?? const ButtonStyle()).merge(
      ElevatedButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, height),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: textStyle,
      ),
    );

    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
