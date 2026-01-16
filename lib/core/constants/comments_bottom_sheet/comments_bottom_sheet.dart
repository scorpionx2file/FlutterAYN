import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';
import '../comment/comment_item.dart';
import 'bottom_comment_input.dart';

class CommentsBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const CommentsBottomSheet({
    required this.scrollController,
  });

  @override
  State<CommentsBottomSheet> createState() => CommentsBottomSheetState();
}

class CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comments = List.generate(
      10,
          (index) => CommentData(
        "https://i.pravatar.cc/150?img=$index",
        "User $index",
        "2h ago",
        null,
        "This is comment number $index",
        false,
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: 8.h),

            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.spanishGrey,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),

            SizedBox(height: 12.h),

            Text(
              "Comments",
              style: AppTextStyles.title,
            ),

            SizedBox(height: 12.h),

            Expanded(
              child: ListView.builder(
                controller: widget.scrollController,
                padding: EdgeInsets.zero,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return CommentItem(
                    data: comments[index],
                  );
                },
              ),
            ),

            Divider(height: 1.h),

            BottomCommentInput(
              controller: _controller,
              focusNode: _focusNode,
              onSend: () {
                final text = _controller.text.trim();
                if (text.isEmpty) return;

                // send to backend here

                _controller.clear();
                _focusNode.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}