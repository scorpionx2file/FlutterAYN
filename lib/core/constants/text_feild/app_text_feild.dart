import 'package:flutter/material.dart';

class AppTextFields extends StatelessWidget {
  const AppTextFields({
    super.key,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.height = 56,
    this.icon,
    this.iconAtStart = true,
    this.iconColor,
    this.onIconPressed,
    this.borderRadius = 14,
    this.borderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.contentPadding,
    this.textAlign = TextAlign.left,
  });

  final TextEditingController controller;

  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int maxLines;
  final double? height;

  final IconData? icon;
  final bool iconAtStart;
  final Color? iconColor;
  final VoidCallback? onIconPressed;

  final double borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final effectiveBorderColor =
        borderColor ??
            (theme.inputDecorationTheme.enabledBorder is OutlineInputBorder
                ? (theme.inputDecorationTheme.enabledBorder as OutlineInputBorder)
                .borderSide
                .color
                : cs.outline);

    final effectiveFocusedBorderColor = focusedBorderColor ?? cs.primary;

    final effectiveFillColor =
        fillColor ?? theme.inputDecorationTheme.fillColor ?? cs.surface;

    final effectiveContentPadding =
        contentPadding ??
            theme.inputDecorationTheme.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16);

    Widget? iconWidget;
    if (icon != null) {
      final iconCore = Icon(icon, color: iconColor ?? theme.iconTheme.color);

      iconWidget = onIconPressed == null
          ? Padding(
        padding: const EdgeInsetsDirectional.only(start: 12, end: 8),
        child: iconCore,
      )
          : IconButton(onPressed: onIconPressed, icon: iconCore);
    }

    final field = Directionality(
      textDirection: TextDirection.ltr,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        readOnly: readOnly || onTap != null,
        onTap: onTap,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        maxLines: maxLines,
        textAlign: textAlign,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.inputDecorationTheme.hintStyle,
          filled: true,
          fillColor: effectiveFillColor,
          contentPadding: effectiveContentPadding,
          prefixIcon: iconAtStart ? null : iconWidget,
          suffixIcon: iconAtStart ? iconWidget : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: effectiveFocusedBorderColor, width: 1.2),
          ),
        ),
      ),
    );

    return height == null ? field : SizedBox(height: height, child: field);
  }
}
