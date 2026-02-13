import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/fonts/app_text_styles.dart';

class PostTypes extends StatelessWidget{
  final String title;
  final String imageUrl;
  final Color color;
  final VoidCallback onTap;

  const PostTypes({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            imageUrl,
            width: 30.w,
            height: 30.h,
            color: color,
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: AppTextStyles.text.copyWith(
              color: color,
            ),
          )
        ]
      ),
    );
  }
}