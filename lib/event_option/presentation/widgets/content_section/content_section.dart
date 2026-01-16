
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/event_option/presentation/widgets/content_section/friends_row.dart';
import 'package:traveller/event_option/presentation/widgets/content_section/info_row.dart';
class PlaceContent{
  final int maxTemp;
  final int minTemp;
  final int numOfPosts;
  final String gateTitle;
  final String gateDesc;
  final List<String> friendsImages;
  final int numOfFriends;

  PlaceContent({
    required this.maxTemp,
    required this.minTemp,
    required this.numOfPosts,
    required this.gateTitle,
    required this.gateDesc,
    required this.friendsImages,
    required this.numOfFriends
});
}


class ContentSection extends StatelessWidget{
final PlaceContent placeContent;

  const ContentSection({
    super.key, required this.placeContent
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            postsNum: placeContent.numOfPosts,
            maxTemp: placeContent.maxTemp,
            minTemp: placeContent.minTemp,
          ),
          SizedBox(height: 10.h),
          Text(
            placeContent.gateTitle,
            style: AppTextStyles.title.copyWith(
              color: AppColors.white
            )
          ),
          SizedBox(height: 5.h),
          Text(
              placeContent.gateDesc,
              maxLines: 3,
              style: AppTextStyles.description.copyWith(
                  color: AppColors.white
              )
          ),
          SizedBox(height: 15.h),
          FriendsRow(
            friendsImages: placeContent.friendsImages,
            friendsNum: placeContent.numOfFriends,
          )
        ]
      ),
    );
  }

}