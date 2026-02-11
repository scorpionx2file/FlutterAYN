import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class ServiceCard extends StatelessWidget {
  final String service;
  final String image;
  final List<Color> colors;
  final bool isSelected; // new

  const ServiceCard({
    super.key,
    required this.service,
    required this.image,
    required this.colors,
    this.isSelected = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185.w,
      height: 195.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        border: Border.all(
          color: isSelected ? AppColors.turnbullBlue : Colors.transparent,
          width: 3.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            PositionedDirectional(
              bottom: 14.h,
              start: 14.w,
              child: Text(
                service,
                style: AppTextStyles.titles.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
