import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderActions extends StatelessWidget {
  const HeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Icon(Icons.search, color: Colors.white,size: 22.sp),
        SizedBox(width: 10.w),
        Icon(Icons.share, color: Colors.white,size: 22.sp),
      ],
    );
  }
}
