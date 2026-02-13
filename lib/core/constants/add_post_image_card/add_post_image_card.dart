import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class AddPostImageCard extends StatelessWidget{
  final String imagePath;
  final VoidCallback onTap;

  const AddPostImageCard({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
              File(imagePath),
              width: 80.w,
              height: 60.h,
              fit: BoxFit.cover,
          )
        ),

        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.delete,
              color: AppColors.lebaneseRed,
              size: 8.sp,
            ),
          ),
        )
      ]
    );
  }
}