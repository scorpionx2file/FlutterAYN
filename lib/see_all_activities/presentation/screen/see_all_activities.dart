import 'package:flutter/material.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/constants/event_options/event_options_activities/event_options_activities.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../core/constants/activity_card/activity_card.dart';

class SeeAllActivities extends StatelessWidget{
  final List<Activity> activities;

  const SeeAllActivities({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
          title: context.l10n.activities,
          showBack: true
      ),
      body: Column(
        children: [
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
              final activity = activities[index];
              final data = EventActivitiesData(
                imageUrl: activity.imageUrl,
                title: activity.title,
                category: activity.category,
                date: activity.time,
              );
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: EventOptionsActivities(data: data),
              );
            }
          )
        ]
      ),
    );
  }
}