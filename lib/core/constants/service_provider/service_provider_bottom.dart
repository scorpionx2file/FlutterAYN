import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/chat_button/chat_button.dart';
import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';

class ServiceProviderBottom extends StatelessWidget{
  final String location;
  final String language;

  const ServiceProviderBottom({
    super.key,
    required this.location,
    required this.language,
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 85.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.deepMarine,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ServiceProviderInfo(
                    icon: Icons.location_pin,
                    info: location,
                  ),
                  SizedBox(height: 5.h),
                  _ServiceProviderInfo(
                    icon: Icons.language,
                    info: language,
                  )
                ],
              ),
            ),
            ChatButton(onTap: (){})
          ],
        ),
      ),
    );
  }
}

class _ServiceProviderInfo extends StatelessWidget{
  final IconData icon;
  final String info;

  const _ServiceProviderInfo({
    super.key,
    required this.icon,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.white,
          size: 16.w,
        ),
        SizedBox(width: 5.w),
        Expanded(
            child: Text(
              info,
              style: AppTextStyles.text.copyWith(
              color: AppColors.white
          ),
        )
        )
      ]
    );
  }
}