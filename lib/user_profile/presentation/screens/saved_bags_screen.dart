import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/constants/post/post.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../widgets/save_bag_tile.dart';

class SavedBagsScreen extends StatelessWidget {
  const SavedBagsScreen({super.key, required this.posts});

  final List<PostData> posts;

  static const List<String> _bags = [
    "Egypt Bag",
    "World Bag",
    "Historical Places",
    "New Year Plan",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: AppColors.black),
        ),
        title: Text(
          "My List",
          style: AppTextStyles.headingH3.copyWith(color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Bags: ${_bags.length}",
                style: AppTextStyles.text.copyWith(
                  color: AppColors.spanishGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: ListView.separated(
                itemCount: _bags.length,
                separatorBuilder: (_, __) => SizedBox(height: 22.h),
                itemBuilder: (_, i) => SavedBagTile(
                  title: _bags[i],
                  onTap: () {
                    context.push(
                      AppRoutes.savedPosts,
                      extra: {
                        "title": _bags[i],
                        "posts": posts,
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}