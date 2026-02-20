import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;

  const AppHeader({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBack
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack ?? () => context.pop(),
      )
          : null,
      title: Text(
        title,
        style: AppTextStyles.titles.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
