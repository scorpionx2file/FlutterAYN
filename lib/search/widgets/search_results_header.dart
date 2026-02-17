import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class SearchResultsHeader extends StatelessWidget {
  const SearchResultsHeader({
    super.key,
    required this.leftText,
    required this.rightText,
  });

  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              leftText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.description.copyWith(
                color: AppColors.spanishGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            rightText,
            style: AppTextStyles.description.copyWith(
              color: AppColors.spanishGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}