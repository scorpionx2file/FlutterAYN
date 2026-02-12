import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/fonts/app_text_styles.dart';

class PostTypes extends StatelessWidget{
  final String title;
  final String imageUrl;
  final Color color;

  const PostTypes({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}