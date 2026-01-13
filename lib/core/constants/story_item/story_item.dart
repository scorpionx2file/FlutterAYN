import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';

class Story{
  final String imageUrl;
  final String? username;
  final bool isSeen;
  final String data;

  Story({
    required this.imageUrl,
    this.username,
    required this.isSeen,
    required this.data,
  });
}

class StoryItem extends StatelessWidget{
  final String imageUrl;
  final String? username;
  final bool isSeen;
  final VoidCallback onTap;

  const StoryItem({
    super.key,
    required this.imageUrl,
    this.username,
    required this.isSeen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
          children: [
            Container(
              padding:  EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSeen ?
                  Border.all(color: AppColors.strongGrey,width: 2.w) :
                  Border.all(color: AppColors.turnbullBlue,width: 3.w)
              ),
              child: CircleAvatar(
                radius: 27.r,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
      
            if(username != null)...[
              SizedBox(height: 1.h),
              Text(
                  username!,
                  style: AppTextStyles.button,
                  overflow: TextOverflow.ellipsis
              )
            ]
          ]
      ),
    );
  }
}