import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../../core/constants/post/post_content/avatars_stack.dart';
import '../../../../core/theme/colors/app_colors.dart';

class FriendsRow extends StatelessWidget{

  final List<String> friendsImages;
  final int friendsNum;

  const FriendsRow({super.key, required this.friendsImages, required this.friendsNum});


  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        AvatarsStack(avatarUrls: friendsImages),

        SizedBox(width: 8.w),

        Text(
            "Friend $friendsNum ",
            style: AppTextStyles.description.copyWith(
              color: AppColors.white,
            )
        )
      ],
    );
  }

}