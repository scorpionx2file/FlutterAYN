import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/post/post_action_row/post_action_row.dart';
import '../../theme/colors/app_colors.dart';
import '../post_service_provider_header/post_or_service_provider_header.dart';
import 'post_content/post_content.dart';

class PostData{
  final PostHeaderData headerData;
  final PostContentData contentData;

  const PostData({
    required this.headerData,
    required this.contentData,
  });
}

class Post extends StatelessWidget{
  final PostHeaderData headerData;
  final PostContentData contentData;
  final VoidCallback onCommentTap;
  final VoidCallback onShareTap;
  final VoidCallback onMoreTap;

  const Post({
    super.key,
    required this.headerData,
    required this.contentData,
    required this.onCommentTap,
    required this.onShareTap,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostOrServiceProviderHeader(data: headerData, onMoreTap: onMoreTap,),

          SizedBox(height: 12.h),

          PostContentSection(data: contentData),

          SizedBox(height: 12.h),

          PostActionsRow(
            onCommentTap: onCommentTap,
            onShareTap: onShareTap,
          ),
        ],
      ),
    );
  }
}