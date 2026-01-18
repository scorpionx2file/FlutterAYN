import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.child,
    this.size = 44,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    final s = size.w;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: s,
          height: s,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
