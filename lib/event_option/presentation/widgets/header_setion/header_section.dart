import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/event_option/presentation/widgets/header_setion/header_action.dart';

class HeaderSection extends StatelessWidget{
  final String gateName;
  const HeaderSection({super.key, required this.gateName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 140.w),
         Text(
              gateName,
              style: AppTextStyles.text.copyWith(
                  color: AppColors.white
              )
          ),
        SizedBox(width: 100.w),
        HeaderActions()
      ],
    );
  }
}