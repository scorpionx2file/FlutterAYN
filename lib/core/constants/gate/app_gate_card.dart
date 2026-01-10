import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart'; // ✅ add

class AppGateBadgeData {
  const AppGateBadgeData({
    required this.icon,
    required this.primaryText,
    required this.secondaryText,
  });

  final IconData icon;
  final String primaryText;
  final String secondaryText;
}

enum AppGateFlagPosition { start, end }

class AppGateCard extends StatelessWidget {
  const AppGateCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    this.flag,
    this.flagPosition = AppGateFlagPosition.start,
    this.badge,
    this.height = 170,
    this.borderRadius = 20,
    this.margin,
    this.overlayHeight = 64,
    this.overlayPadding = const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    this.overlayGradientOpacity = 0.75,
    this.badgePadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.badgeMargin = const EdgeInsets.all(12),
    this.badgeOpacity = 0.55,
    this.badgeRadius = 18,
    this.titleStyle,
    this.titleMaxLines = 2,
  });

  final String title;
  final ImageProvider image;
  final VoidCallback onTap;

  final Widget? flag;
  final AppGateFlagPosition flagPosition;

  final AppGateBadgeData? badge;

  final double height;
  final double borderRadius;
  final EdgeInsets? margin;

  final double overlayHeight;
  final EdgeInsets overlayPadding;
  final double overlayGradientOpacity;

  final EdgeInsets badgePadding;
  final EdgeInsets badgeMargin;
  final double badgeOpacity;
  final double badgeRadius;

  final TextStyle? titleStyle;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    final cardHeight = height.h;
    final cardCornerRadius = borderRadius.r;

    final overlayBarHeight = overlayHeight.h;
    final overlayContentPadding = overlayPadding.copyWith(
      left: overlayPadding.left.w,
      right: overlayPadding.right.w,
      top: overlayPadding.top.h,
      bottom: overlayPadding.bottom.h,
    );

    final outerMargin = (margin ?? EdgeInsets.zero).copyWith(
      left: (margin?.left ?? 0).w,
      right: (margin?.right ?? 0).w,
      top: (margin?.top ?? 0).h,
      bottom: (margin?.bottom ?? 0).h,
    );

    final badgeContentPadding = badgePadding.copyWith(
      left: badgePadding.left.w,
      right: badgePadding.right.w,
      top: badgePadding.top.h,
      bottom: badgePadding.bottom.h,
    );

    final badgeOuterMargin = badgeMargin.copyWith(
      left: badgeMargin.left.w,
      right: badgeMargin.right.w,
      top: badgeMargin.top.h,
      bottom: badgeMargin.bottom.h,
    );

    final badgeCornerRadius = badgeRadius.r;

    final titleTextStyle = (titleStyle ?? AppTextStyles.titles).copyWith(
      color: AppColors.white,
      height: 1.1,
    );

    final badgePrimaryTextStyle = AppTextStyles.button.copyWith(
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      height: 1.0,
    );

    final badgeSecondaryTextStyle = AppTextStyles.description.copyWith(
      color: AppColors.white.withOpacity(0.9),
      height: 1.0,
    );

    Widget buildTitleWithOptionalFlag() {
      final titleText = Expanded(
        child: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: titleMaxLines,
          overflow: TextOverflow.ellipsis,
          style: titleTextStyle,
        ),
      );

      final flagIcon = flag == null
          ? null
          : SizedBox(
        width: 18.w,
        height: 18.h,
        child: FittedBox(fit: BoxFit.contain, child: flag!),
      );

      if (flagIcon == null) return Row(children: [titleText]);

      return Row(
        children: flagPosition == AppGateFlagPosition.start
            ? [flagIcon, SizedBox(width: 10.w), titleText]
            : [titleText, SizedBox(width: 10.w), flagIcon],
      );
    }

    return Padding(
      padding: outerMargin,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(cardCornerRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: cardHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(image: image, fit: BoxFit.cover),

                if (badge != null)
                  Positioned(
                    top: badgeOuterMargin.top,
                    left: badgeOuterMargin.left,
                    child: Container(
                      padding: badgeContentPadding,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(badgeOpacity),
                        borderRadius: BorderRadius.circular(badgeCornerRadius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(badge!.icon, color: AppColors.white, size: 18.sp),
                          SizedBox(width: 8.w),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(badge!.primaryText, style: badgePrimaryTextStyle),
                              SizedBox(height: 2.h),
                              Text(badge!.secondaryText, style: badgeSecondaryTextStyle),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: overlayBarHeight,
                  child: Container(
                    padding: overlayContentPadding,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.black.withOpacity(0.0),
                          AppColors.black.withOpacity(overlayGradientOpacity),
                        ],
                      ),
                    ),
                    child: Center(child: buildTitleWithOptionalFlag()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
