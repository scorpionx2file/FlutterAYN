import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../core/constants/activity_card/activity_card.dart';
import '../../../core/constants/activity_card/activity_carousel.dart';
import '../../../core/constants/post/post.dart';
import '../../../core/constants/report/report_bottom_sheet.dart';
import '../../../core/constants/user_profile/user_profile_header.dart';

class UserProfileScreen extends StatelessWidget {
  final List<PostData> postData;
  final List<Activity> activities;

  const UserProfileScreen({
    super.key,
    required this.activities,
    required this.postData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: UserProfileHeader(
            isMyProfile: true,
            isVerified: true,
            coverImage: const AssetImage('assets/images/profileCover.png'),
            profileImage: const AssetImage('assets/images/profile.png'),
            username: 'محمود السعدي',
            jobTitle: 'مقدم خدمة',
            bio:
                'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيُلهي القارئ',
            location: 'الغردقة، مصر',
            firstNumber: 1689,
            secondNumber: 31700,
            thirdNumber: 735,
            onTwitterTap: () {},
            onSnapchatTap: () {},
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 14.h)),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.calendar_today, size: 22.r),
                SizedBox(width: 6.w),
                Text(
                  "Member-Specific Events",
                  style: AppTextStyles.titles.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 8.h)),

        SliverToBoxAdapter(
          child: ActivityCarousel(activities: activities, isYellow: true),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 8.h)),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Post(
                headerData: postData[index].headerData,
                contentData: postData[index].contentData,
                onShareTap: () {},
                onMoreTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const ReportBottomSheet(),
                  );
                },
                isVideoScreen: false,
              ),
            ),
            childCount: postData.length,
          ),
        ),
      ],
    );
  }
}
