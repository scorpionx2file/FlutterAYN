import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
        IconButton(
            onPressed: (){
              context.pop();
            },
            icon: Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 20.r)),

        SizedBox(width: 90.w),
         Text(
              gateName,
              style: AppTextStyles.text.copyWith(
                  color: AppColors.white
              )
          ),
        SizedBox(width: 90.w),
        HeaderActions()
      ],
    );
  }
}