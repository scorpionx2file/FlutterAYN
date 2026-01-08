import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import '../../theme/fonts/app_text_styles.dart';

class ReportBottomSheet extends StatefulWidget {
  const ReportBottomSheet({super.key});

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  int selectedIndex = 0;

  final List<String> reasons = [
    'Misleading content',
    'Copyright violation',
    'Contains violent content',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        12.w,
        12.h,
        12.w,
        MediaQuery.of(context).viewInsets.bottom + 12.h,
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 150.w,
              height: 4.h,
              margin:  EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: AppColors.spanishGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
           Padding(
             padding: const EdgeInsets.only(left: 18.0),
             child: Text(
              'Report Content',
              style: AppTextStyles.headingH3.copyWith(
                color: AppColors.strongGrey,
              ),
          ),
           ),
          SizedBox(height: 16.h),
          ...List.generate(
            reasons.length,
                (index) => RadioListTile(
              value: index,
              groupValue: selectedIndex,
              activeColor: AppColors.lebaneseRed,
              title: Text(
                reasons[index],
                style: AppTextStyles.text.copyWith(
                  color: selectedIndex == index
                      ? AppColors.lebaneseRed
                      : AppColors.strongGrey,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedIndex = value!;
                });
              },
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lebaneseRed,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Send",
              style: AppTextStyles.titles.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
