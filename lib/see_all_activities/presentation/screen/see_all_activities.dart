import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/event_options/event_options_activities/event_options_activities.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../core/constants/activity_card/activity_card.dart';
import '../../../core/theme/fonts/app_text_styles.dart';

class SeeAllActivities extends StatelessWidget{
  final List<Activity> activities;

  const SeeAllActivities({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            context.l10n.activities,
            style: AppTextStyles.title,
          ),
          SizedBox(height: 8.h),
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