import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constatns/post/post_content/comments_preview_row.dart';
import 'package:traveller/core/constatns/post/post_content/media_section.dart';

class PostContentData {
  final List<String> mediaUrls;
  final List<String> commenterAvatars;
  final String commentsCountText;

  const PostContentData({
    required this.mediaUrls,
    required this.commenterAvatars,
    required this.commentsCountText,
  });
}

class PostContentSection extends StatelessWidget{
  final PostContentData data;

  const PostContentSection({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(data.mediaUrls.isNotEmpty)
          MediaSection(mediaUrls: data.mediaUrls),
        SizedBox(height: 12.h),
        CommentsPreviewRow(
          avatarUrls: data.commenterAvatars,
          commentsCountText: data.commentsCountText,
        )
      ],
    );
  }
}