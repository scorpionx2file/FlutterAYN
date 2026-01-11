import 'package:flutter/material.dart';
import 'package:traveller/core/constants/post/post.dart';

import '../../../core/constants/report/report_bottom_sheet.dart';

class VideoAndArticlesScreen extends StatefulWidget{
  const VideoAndArticlesScreen({super.key, required this.postData});
  final PostData postData;

  @override
  State<VideoAndArticlesScreen> createState() => _VideoAndArticlesScreenState();

}

class _VideoAndArticlesScreenState extends State<VideoAndArticlesScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Post(
        headerData: widget.postData.headerData,
        contentData: widget.postData.contentData,
        onCommentTap: (){},
        onShareTap: (){},
        onMoreTap: (){
          showModalBottomSheet(
            context: context,
            builder: (context) => const ReportBottomSheet(),
          );
        }
      ),
    );
  }

}