import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/post_service_provider_header/post_or_service_provider_header.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'header_actions.dart';
import 'header_avatar.dart';
import 'header_use_info.dart';

class HeaderTopRow extends StatelessWidget {
  final PostHeaderData data;
  final VoidCallback onMoreTap;

  const HeaderTopRow({
    super.key,
    required this.data,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = data.isHighlighted ? AppColors.darkYellow : AppColors.spanishGrey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderAvatar(imageUrl: data.imageUrl),

        SizedBox(width: 10.w),

        Expanded(
          child: HeaderUserInfo(
              data: data,
              isHighlighted: data.isHighlighted
          ),
        ),

        HeaderActions(
          iconColor: iconColor,
          onMoreTap: onMoreTap,
          isHighlighted: data.isHighlighted
        ),
      ],
    );
  }
}
