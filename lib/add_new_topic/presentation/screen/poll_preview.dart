import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class PollData {
  final String question;
  final List<String> options;

  PollData({required this.question, required this.options});
}

class PollPreview extends StatelessWidget {
  final String question;
  final List<String> options;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PollPreview({
    super.key,
    required this.question,
    required this.options,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Poll",
                  style: AppTextStyles.title.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    if (onEdit != null)
                      IconButton(
                        icon: Icon(Icons.edit, color: AppColors.turnbullBlue),
                        onPressed: onEdit,
                        tooltip: "Edit Poll",
                      ),
                    if (onDelete != null)
                      IconButton(
                        icon: Icon(Icons.delete, color: AppColors.lebaneseRed),
                        onPressed: onDelete,
                        tooltip: "Delete Poll",
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),

            Text(
              question,
              style: AppTextStyles.titles.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),

            ...options.map((option) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  Icon(Icons.circle_outlined, size: 18.sp, color: AppColors.strongGrey),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(option, style: AppTextStyles.titles),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
