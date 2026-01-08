import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/colors/app_colors.dart';

class AvatarsStack extends StatelessWidget {
  final List<String> avatarUrls;

  const AvatarsStack({
    super.key,
    required this.avatarUrls
  });

  @override
  Widget build(BuildContext context) {
    final visibleAvatars = avatarUrls.take(3).toList();

    return SizedBox(
      width: (visibleAvatars.length * 16 + 24).w,
      height: 24.h,
      child: Stack(
          children: List.generate(visibleAvatars.length, (index){
            return Positioned(
              left: (index*16).w,
              child: CircleAvatar(
                radius: 12.r,
                backgroundImage: NetworkImage(visibleAvatars[index]),
                backgroundColor: AppColors.spanishGrey,
              ),
            );
          })
      ),
    );
  }
}