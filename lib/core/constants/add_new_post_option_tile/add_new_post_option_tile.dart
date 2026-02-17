import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/colors/app_colors.dart';
import '../app_tile/app_tile.dart';

class AddNewPostOptionTile extends StatelessWidget{
  final Widget icon;
  final String title;
  final bool showIcon;
  final bool showDivider;
  final VoidCallback onTap;

  const AddNewPostOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.showIcon = true,
    this.showDivider = true,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: AppTile(
        icon: icon,
        title: title,
        showDivider: showDivider,
        showIcon: showIcon,
        onTap: onTap,
      ),
    );
  }
}