
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class RatingWidget extends StatelessWidget{
  final double rating;

  const RatingWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        SizedBox(width: 4.w),
        Text(
          rating.toString(),
          style: AppTextStyles.description.copyWith(color: AppColors.white),
        ),
      ],
    );
  }

}