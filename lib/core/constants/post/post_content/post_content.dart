import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'comments_preview_row.dart';
import 'media_section.dart';

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
  final VoidCallback onCommentsTap;

  const PostContentSection({
    super.key,
    required this.data,
    required this.onCommentsTap,
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
          onCommentsTap: onCommentsTap,
        )
      ],
    );
  }
}