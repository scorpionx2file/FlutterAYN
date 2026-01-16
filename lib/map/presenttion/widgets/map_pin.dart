
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import 'map_screen.dart';

class MapPin extends StatelessWidget {
  final MapItem item;

  const MapPin({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isPost = item.type == MarkerType.post;

    final Color pinColor =
    isPost ? AppColors.lebaneseRed : AppColors.turnbullBlue;

    return SizedBox(
      width: 56.w,
      height: 64.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// Shadow
          Positioned(
            bottom: 4.h,
            child: Container(
              width: 36.w,
              height: 10.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: pinColor.withOpacity(0.5),
                    blurRadius: 16.r,
                    spreadRadius: 2.r,
                  ),
                ],
              ),
            ),
          ),

          /// Pin body
          ClipPath(
            clipper: PinClipper(),
            child: Container(
              color: pinColor,
            ),
          ),

          /// Avatar + optional play icon
          Positioned(
            top: 6.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// Avatar
                Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                    Border.all(color: AppColors.white, width: 2.w),
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// ▶ Play icon (ONLY for posts)
                if (isPost)
                  SizedBox(
                    width: 18.w,
                    height: 18.h,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PinClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(Size size) {
    final ui.Path path = ui.Path();

    path.moveTo(size.width / 2, size.height);

    path.quadraticBezierTo(
      size.width * 1.1,
      size.height * 0.65,
      size.width,
      size.height * 0.45,
    );

    path.arcToPoint(
      Offset(0, size.height * 0.45),
      radius: Radius.circular(size.width / 2),
      clockwise: false,
    );

    path.quadraticBezierTo(
      -size.width * 0.1,
      size.height * 0.65,
      size.width / 2,
      size.height,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<ui.Path> oldClipper) => false;
}