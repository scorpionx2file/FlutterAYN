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

  const Post({
    super.key,
    required this.headerData,
    required this.contentData,
    required this.onShareTap,
    required this.onMoreTap,
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
                onCommentsTap: () => _openCommentsBottomSheet(context)
            ),

            SizedBox(height: 12.h),

            PostActionsRow(
              onShareTap: widget.onShareTap,
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