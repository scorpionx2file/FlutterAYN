import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/profile_settings/profile_settings_tile_segmented_toggle.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../../theme/colors/app_colors.dart';

class AddNewHeader extends StatelessWidget{
  final String imageUrl;
  final String location;
  final bool isEventPage;
  final Function(int)? onToggleChanged;
  final int? selectedIndex;

  const AddNewHeader({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.isEventPage,
    this.onToggleChanged,
    this.selectedIndex
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: NetworkImage(imageUrl),
        ),
        SizedBox(width: 4.w),
        Icon(
          Icons.location_pin,
          color: AppColors.spanishGrey,
          size: 8.sp,
        ),
        SizedBox(width: 4.w),
        Text(
          location,
          style: AppTextStyles.smallText.copyWith(
            color: AppColors.spanishGrey
          )
        ),
        SizedBox(width: 50.w),
        if(isEventPage)...[
         ProfileSettingsTileSegmentedToggle(
           options: ["Paid","Not Paid"],
           selectedIndex: selectedIndex!,
           onChanged: (value) {
             if (onToggleChanged != null) {
               onToggleChanged!(value);
             }
           },
         )
        ]
      ]
    );
  }
}