import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/event_options/event_options_posts/event_options_posts.dart';
import 'package:traveller/core/constants/service_provider/service_provider.dart';
import '../../../../core/constants/event_options/event_options_activities/event_options_activities.dart';
import '../../../../core/constants/post_service_provider_header/post_or_service_provider_header.dart';

class ServiceProviderData{
  final PostHeaderData data;
  final String location;
  final String language;

  const ServiceProviderData({
    required this.data,
    required this.location,
    required this.language,
  });
}


class EventList extends StatelessWidget {
  final List<EventPostsData> posts;
  final List<EventActivitiesData> activities;
  final List<ServiceProviderData> services;
  final int selectedIndex;

  const EventList({
    super.key,
    required this.posts,
    required this.activities,
    required this.selectedIndex, required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _itemCount,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (_, index) => _buildItem(index),
    );
  }

  int get _itemCount {
    switch (selectedIndex) {
      case 0:
        return posts.length;
      case 1:
        return activities.length;
      case 2:
        return services.length;
      default:
        return 0;
    }
  }

  Widget _buildItem(int index) {
    switch (selectedIndex) {
      case 0:
        return EventOptionsPosts(
          data: posts[index],
        );

      case 1:
        return EventOptionsActivities(
          data: activities[index],
        );

      case 2:
        return ServiceProvider(
          data: services[index].data,
          location: services[index].location,
          language: services[index].language,
        );

      default:
        return const SizedBox();
    }
  }
}
