import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/event_options/event_options_posts/event_options_posts.dart';

class EventList extends StatelessWidget{
  final List<EventPostsData> posts;

  const EventList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (_, __) => EventOptionsPosts(data: posts[__]),
    );
  }

}