import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../core/constants/button/app_button.dart';
import '../../../core/theme/colors/app_colors.dart';


class PointsWelcomeDialog extends StatelessWidget {
  const PointsWelcomeDialog({
    super.key,
    required this.points,
    required this.onStart,
    this.illustrationAsset = 'assets/images/welcome_points.png',
  });

  final int points;
  final VoidCallback onStart;
  final String illustrationAsset;

  static Future<void> show(
      BuildContext context, {
        required int points,
        required VoidCallback onStart,
        String? illustrationAsset,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => PointsWelcomeDialog(
        points: points,
        onStart: onStart,
        illustrationAsset: illustrationAsset ?? 'assets/images/welcome_points.png',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 18.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: EdgeInsets.all(6.r),
                  child: Icon(
                    Icons.close,
                    size: 18.r,
                    color: AppColors.spanishGrey,
                  ),
                ),
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              context.l10n.pointsDialogTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.strongGrey,
              ),
            ),

            SizedBox(height: 12.h),

            SizedBox(
              height: 120.h,
              child: Image.asset(illustrationAsset, fit: BoxFit.contain),
            ),

            SizedBox(height: 14.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$points',
                  style: TextStyle(
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.neonCoral,
                    height: 1,
                  ),
                ),
                SizedBox(width: 6.w),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    context.l10n.pointsUnitShort,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.spanishGrey,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            Text(
              context.l10n.pointsDialogSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.spanishGrey,
                height: 1.4,
              ),
            ),

            SizedBox(height: 16.h),

            AppButton(
              text: context.l10n.pointsDialogCta,
              onPressed: () {
                Navigator.pop(context);
                onStart();
              },
              height: 42,
              backgroundColor: AppColors.turnbullBlue,
              foregroundColor: AppColors.white,
              borderRadius: 12,
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}