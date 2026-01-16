import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/fonts/app_text_styles.dart';

class MapSearchBar extends StatefulWidget{
  const MapSearchBar({super.key});

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12.r),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search location...',
          hintStyle: AppTextStyles.description.copyWith(
            color: AppColors.strongGrey,
          ),
          prefixIcon: const Icon(Icons.arrow_back),
          suffixIcon: const Icon(Icons.saved_search_sharp),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          EdgeInsets.symmetric(vertical: 14.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}