import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/post/post.dart';

class PostResultsList extends StatelessWidget {
  const PostResultsList({
    super.key,
    required this.query,
    required this.posts,
    required this.onOpenPost,
  });

  final String query;
  final List posts;
  final void Function(String postId) onOpenPost;

  @override
  Widget build(BuildContext context) {
    final q = query.trim().toLowerCase();

    final filtered = q.isEmpty
        ? posts
        : posts.where((p) {
      final h = p.headerData;
      final user = (h.username ?? "").toString().toLowerCase();
      final desc = (h.description ?? "").toString().toLowerCase();
      return user.contains(q) || desc.contains(q);
    }).toList();

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final post = filtered[index];
        final id = post.headerData.postId?.toString() ?? "";

        return Post(
          headerData: post.headerData,
          contentData: post.contentData,
          onShareTap: () {},
          onMoreTap: () {},
          isVideoScreen: false,
        );
      },
    );
  }
}