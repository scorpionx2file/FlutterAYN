import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/constants/post/post_action_row/post_action_row.dart';
import '../../../config/routes/app_routes.dart';
import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';
import '../comment/comment_item.dart';
import '../comments_bottom_sheet/bottom_comment_input.dart';
import '../comments_bottom_sheet/comments_bottom_sheet.dart';
import '../post_service_provider_header/post_or_service_provider_header.dart';
import 'post_content/post_content.dart';
import 'package:share_plus/share_plus.dart';

class PostData{
  final PostHeaderData headerData;
  final PostContentData contentData;

  const PostData({
    required this.headerData,
    required this.contentData,
  });
}

class Post extends StatefulWidget {
  final PostHeaderData headerData;
  final PostContentData contentData;
  final VoidCallback onShareTap;
  final VoidCallback onMoreTap;
  final bool isVideoScreen;

  const Post({
    super.key,
    required this.headerData,
    required this.contentData,
    required this.onShareTap,
    required this.onMoreTap,
    required this.isVideoScreen,
  });

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool _showCommentBox = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  void _openComment() {
    setState(() {
      _showCommentBox = true;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _focusNode.requestFocus();
    });
  }

  void _closeComment() {
    setState(() {
      _showCommentBox = false;
    });
    _focusNode.unfocus();
  }

  void _sendComment() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    //send the comment to backend

    _controller.clear();
    _closeComment();
  }

  void _openCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (_, scrollController) {
            return CommentsBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  void _sharePost() {
    final postId = widget.headerData.postId;
    final shareLink = 'https://travellerapp.com/post/$postId';
    const shareText = "Check out this post on Traveller ✈️";

    Share.share(
      '$shareText\n\n$shareLink',
      subject: 'Traveller Post',
      sharePositionOrigin: Rect.fromLTWH(0, 0, MediaQuery.of(context).size.width, 100),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _closeComment(),
      child: Container(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap:(){
                final location = GoRouterState.of(context).uri;

                if(location.path != AppRoutes.Video){
                  context.push(AppRoutes.Video,
                      extra: PostData(
                          headerData: widget.headerData,
                          contentData: widget.contentData
                      )
                  );
                }
              },
              child: PostOrServiceProviderHeader(
                data: widget.headerData,
                onMoreTap: widget.onMoreTap,
              ),
            ),

            SizedBox(height: 12.h),

            PostContentSection(
                data: widget.contentData,
                isVideoScreen: widget.isVideoScreen,
                onCommentsTap: () => _openCommentsBottomSheet(context)
            ),

            SizedBox(height: 12.h),

            PostActionsRow(
              onShareTap: _sharePost,
              onCommentTap: _openComment,
            ),

            if (_showCommentBox)
              GestureDetector(
                onTap: () {},
                child: BottomCommentInput(
                  controller: _controller,
                  focusNode: _focusNode,
                  onSend: _sendComment,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CommentInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;

  const _CommentInput({
    required this.controller,
    required this.focusNode,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Write a comment...",
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: AppColors.turnbullBlue,
                    width: 1.w,
                  ),
                ),
              ),
              style: AppTextStyles.description,
            ),
          ),

          SizedBox(width: 8.w),

          GestureDetector(
            onTap: onSend,
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.turnbullBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send_rounded,
                color: AppColors.white,
                size: 18.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
