import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class SearchResultsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchResultsAppBar({
    super.key,
    required this.title,
    required this.onBack,
  });

  final String title;
  final VoidCallback onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, size: 18.r),
        onPressed: onBack,
      ),
      title: Text(
        title,
        style: AppTextStyles.titles.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}