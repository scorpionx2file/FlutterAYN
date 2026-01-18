import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import '../../../core/constants/gate/app_gate_card.dart';

class SelectableGateCard extends StatelessWidget {
  const SelectableGateCard({
    super.key,
    required this.title,
    required this.image,
    required this.selected,
    required this.onTap,
    this.borderRadius = 20,
  });

  final String title;
  final ImageProvider image;
  final bool selected;
  final VoidCallback onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius.r;

    return Stack(
      children: [
        AppGateCard(
          title: title,
          image: image,
          onTap: onTap,
          borderRadius: borderRadius,
        ),
        if (selected)
          Positioned.fill(
            child: IgnorePointer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                ),
              ),
            ),
          ),

        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: selected ? 1 : 0,
              child: Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 150),
                  scale: selected ? 1 : 0.92,
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_outlined,
                      size: 20.sp,
                      color: AppColors.turnbullBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
