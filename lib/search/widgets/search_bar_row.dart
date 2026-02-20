import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import 'search_filter_sheet.dart';

class SearchBarRow extends StatelessWidget {
  const SearchBarRow({
    super.key,
    required this.controller,
    required this.selectedIndex,
    required this.onApplyFilter,
  });

  final TextEditingController controller;

  final int selectedIndex;

  final ValueChanged<int> onApplyFilter;

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
            onPressed: () async {
              final index = await showModalBottomSheet<int>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                ),
                builder: (_) => SearchFilterSheet(initialIndex: selectedIndex),
              );

              if (index != null) onApplyFilter(index);
            },
            icon: Icon(Icons.tune, color: AppColors.strongGrey, size: 22.r),
          ),
        ],
      ),
    );
  }
}