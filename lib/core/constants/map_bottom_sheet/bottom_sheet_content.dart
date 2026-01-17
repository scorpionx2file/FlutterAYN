import 'package:flutter/material.dart';

import '../../../map/presenttion/widgets/map_screen.dart';
import '../comment/comment_item.dart';
import '../post/post.dart';
import '../service_provider/service_provider.dart';

class BottomSheetContent extends StatelessWidget {
  final MapItem item;

  const BottomSheetContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (item.type == MarkerType.post)
          Post(
            headerData: item.postData!,
            contentData: item.postContentData!,
            onShareTap: () {},
            onMoreTap: () {},
            isVideoScreen: false,
          )
        else
          ServiceProvider(
            data: item.serviceHeaderData!,
            location: item.locationText!,
            language: item.language!,
          ),

        /// 🔽 COMMENTS
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item.comments.length,
          itemBuilder: (_, index) {
            return CommentItem(data: item.comments[index]);
          },
        ),
      ],
    );
  }
}
