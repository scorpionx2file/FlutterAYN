import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'expandable_text.dart';
import 'header_meta.dart';
import 'header_top_row.dart';

class PostHeaderData {
  final String postId;
  final String imageUrl;
  final String username;
  final String jobOrLocation;
  final double? rate;
  final String? postTitle;
  final String? date;
  final String description;
  final bool isHighlighted;

  const PostHeaderData({
    required this.postId,
    required this.imageUrl,
    required this.username,
    required this.jobOrLocation,
    this.rate,
    this.postTitle,
    this.date,
    required this.description,
    this.isHighlighted = false,
  });
}

class PostOrServiceProviderHeader extends StatelessWidget{
  final PostHeaderData data;
  final VoidCallback onMoreTap;

  const PostOrServiceProviderHeader({
    super.key,
    required this.data,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTopRow(
            data: data,
            onMoreTap: onMoreTap,
          ),

          if (data.postTitle != null || data.date != null)
            HeaderMeta(
              title: data.postTitle,
              date: data.date,
              isHighlighted: data.isHighlighted,
            ),

          SizedBox(height: 8.h),

          ExpandableText(
              text: data.description,
              isHighlighted: data.isHighlighted
          ),
        ]
      )
    );
  }
}