import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/comment/rating_widget.dart';
import 'package:traveller/core/constants/post/post.dart';

import '../../../core/constants/comment/comment_item.dart';
import '../../../core/constants/report/report_bottom_sheet.dart';
import '../../../core/theme/colors/app_colors.dart';

class VideoAndArticlesScreen extends StatefulWidget{

  const VideoAndArticlesScreen({super.key, required this.postData});
  final PostData postData;

  @override
  State<VideoAndArticlesScreen> createState() => _VideoAndArticlesScreenState();

}

class _VideoAndArticlesScreenState extends State<VideoAndArticlesScreen>{
  late final List<CommentData> comments;

  @override
  void initState() {
    super.initState();

    comments = [
      CommentData(
        'https://i.pravatar.cc/150?img=1',
        'Ahmed',
        '2h',
        const Icon(Icons.favorite,color: AppColors.spanishGrey,size: 18),
        'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
        false,
      ),
      CommentData(
        'https://i.pravatar.cc/150?img=2',
        'Sara',
        '1h',
        RatingWidget(rating: 3.6),
        'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
        true
      ),
      CommentData(
        'https://i.pravatar.cc/150?img=3',
        'Omar',
        '10m',
        const Icon(Icons.shopping_bag_rounded, color: AppColors.spanishGrey, size: 18),
        'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
        false
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [

          // 🔹 Post
          SliverToBoxAdapter(
            child: Post(
              headerData: widget.postData.headerData,
              contentData: widget.postData.contentData,
              onShareTap: () {},
              onMoreTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ReportBottomSheet(),
                );
              },
            ),
          ),

          // 🔹 Comments list
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.h),
                  child: CommentItem(
                    data: comments[index],
                  ),
                );
              },
              childCount: comments.length,
            ),
          ),
        ],
      ),
    );
  }



}