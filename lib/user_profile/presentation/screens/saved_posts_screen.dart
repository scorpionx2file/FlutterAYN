import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/constants/post/post.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../../core/constants/report/report_bottom_sheet.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({
    super.key,
    required this.title,
    required this.posts,
  });

  final String title;
  final List<PostData> posts;

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  final _searchCtrl = TextEditingController();
  String _q = "";

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<PostData> get _filtered {
    final q = _q.trim().toLowerCase();
    if (q.isEmpty) return widget.posts;

    return widget.posts.where((p) {
      final h = p.headerData;
      final username = (h.username).toLowerCase();
      final job = (h.jobOrLocation).toLowerCase();
      final desc = (h.description ?? "").toLowerCase();
      return username.contains(q) || job.contains(q) || desc.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final posts = _filtered;

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
          widget.title,
          style: AppTextStyles.headingH3.copyWith(color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextFields(
              controller: _searchCtrl,
              hintText: context.l10n.searchHere,
              icon: Icons.search,
              iconAtStart: true,
              onChanged: (v) => setState(() => _q = v),
            ),

            SizedBox(height: 12.h),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                context.l10n.savedCount(posts.length),
                style: AppTextStyles.text.copyWith(
                  color: AppColors.spanishGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            Expanded(
              child: ListView.separated(
                itemCount: posts.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, i) {
                  final p = posts[i];
                  return Post(
                    headerData: p.headerData,
                    contentData: p.contentData,
                    isVideoScreen: false,
                    onShareTap: () {},
                    onMoreTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => const ReportBottomSheet(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}