import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class SearchBarRow extends StatelessWidget {
  const SearchBarRow({
    super.key,
    required this.controller,
    required this.onFilterTap,
  });

  final TextEditingController controller;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: AppTextFields(
              controller: controller,
              hintText: l10n.searchHint,
              height: 52.h,
              contentPadding: EdgeInsets.all(16.r),
              icon: Icons.search,
              iconAtStart: true,
              iconColor: AppColors.turnbullBlue,
            ),
          ),
          IconButton(
            onPressed: onFilterTap,
            icon: Icon(Icons.tune, color: AppColors.strongGrey, size: 22.r),
          ),
        ],
      ),
    );
  }
}