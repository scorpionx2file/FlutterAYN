
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../map/presenttion/widgets/map_screen.dart';
import '../constants/map_bottom_sheet/bottom_sheet_content.dart';
import '../theme/colors/app_colors.dart';

void openMapItemBottomSheet(
    BuildContext context,
    MapItem item,
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.35,
        maxChildSize: 0.9,
        builder: (_, controller) {
          return Container(
            decoration: BoxDecoration(
              color: item.type == MarkerType.service ? AppColors.turnbullBlue: AppColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.r),
              ),
            ),
            child: SingleChildScrollView(
              controller: controller,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: BottomSheetContent(item: item),
              ),
            ),
          );
        },
      );
    },
  );
}
