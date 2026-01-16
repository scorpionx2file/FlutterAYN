import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'activity_card.dart';

class ActivityCarousel extends StatefulWidget {
  final List<Activity> activities;
  final double height;
  final bool isYellow;

  const ActivityCarousel({
    super.key,
    required this.activities,
    this.height = 110,
    required this.isYellow,
  });

  @override
  State<ActivityCarousel> createState() => _ActivityCarouselState();
}

class _ActivityCarouselState extends State<ActivityCarousel> {
  late final PageController _controller;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = PageController(viewportFraction: 0.9.w);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_controller.hasClients) return;

      _currentPage++;
      _controller.animateToPage(
        _currentPage % widget.activities.length,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.activities.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final activity = widget.activities[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ActivityCard(
                  imageUrl: activity.imageUrl,
                  activityTitle: activity.title,
                  activityCategory: activity.category,
                  activityTime: activity.time,
                  isYellow: widget.isYellow,
                ),
              );
            },
          ),
        ),

        SizedBox(height: 8.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.activities.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == _currentPage
                    ? AppColors.lebaneseRed
                    : AppColors.spanishGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

}