import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/post/post.dart';
import 'package:traveller/core/constants/story_item/story_item.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import '../../../core/constants/activity_card/activity_card.dart';
import '../../../core/constants/activity_card/activity_carousel.dart';
import '../../../core/theme/fonts/app_text_styles.dart';

class HomeScreen extends StatelessWidget{
  final List<Story> stories;
  final List<PostData> postData;
  final List<Activity> activities;

  const HomeScreen({
    super.key,
    required this.stories,
    required this.postData,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _HomeTopBar(),
        ),

        SliverToBoxAdapter(
          child: _StoryList(stories: stories),
        ),

        SliverToBoxAdapter(
          child: _SectionHeader(
              title: "Activities",
              actionText: "See all",
              isPostTitle: false
          ),
        ),

        SliverToBoxAdapter(
          child: ActivityCarousel(
            activities: activities,
            isYellow: true,
          ),
        ),

        SliverToBoxAdapter(
          child: _SectionHeader(
              title: "Recent Posts",
              actionText: "Location"
          ),
        ),

        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Post(
                      headerData: postData[index].headerData,
                      contentData: postData[index].contentData,
                      onShareTap: (){},
                      onMoreTap: (){}
                  ),
                ),
              childCount: postData.length,
            )
        )
      ]
    );
  }
}

class _HomeTopBar extends StatelessWidget{
  const _HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Image.asset(
            'assets/images/icons/logo.png',
            width: 60.w,
            height: 50.h,
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              GestureDetector(
                onTap: (){},
                child: Image.asset(
                    "assets/images/icons/search.png",
                    width: 18.w,
                    height: 18.h,
                  color: AppColors.strongGrey,
                )
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: (){},
                child: Image.asset(
                    "assets/images/icons/notification.png",
                    width: 18.w,
                    height: 18.h,
                    color: AppColors.strongGrey
                )
              )
            ],
            )
          )
        ],
      ),
    );
  }
}

class _StoryList extends StatelessWidget{
  final List<Story> stories;

  const _StoryList({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StoryItem(
              imageUrl: story.imageUrl,
              username: story.username,
              isSeen: story.isSeen,
              onTap: () {  },
            ),
          );
        }
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget{
  final String title;
  final String actionText;
  final bool isPostTitle;

  const _SectionHeader({
    super.key,
    required this.title,
    required this.actionText,
    this.isPostTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.titles.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold
            ),
          ),
          Row(
            children: [
              if(isPostTitle)
                Icon(
                  Icons.location_pin,
                  color: AppColors.turnbullBlue,
                  size: 10.w,
                ),
              SizedBox(width: 5.w),
              Text(
                actionText,
                style: AppTextStyles.button.copyWith(
                  color: isPostTitle ? AppColors.turnbullBlue : AppColors.strongGrey
                ),
              )
            ],
          )
        ]
      )
    );
  }
}