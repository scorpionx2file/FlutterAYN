import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/followers_list/followers_list_tile.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class PeopleResultsList extends StatelessWidget {
  const PeopleResultsList({
    super.key,
    required this.query,
    required this.following,
    required this.followers,
  });

  final String query;
  final List following;
  final List followers;

  @override
  Widget build(BuildContext context) {
    final q = query.trim().toLowerCase();
    final all = [...following, ...followers];

    final filtered = q.isEmpty
        ? all
        : all.where((p) => (p.name as String).toLowerCase().contains(q)).toList();

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final item = filtered[index];

        return FollowersListTile(
          story: item.story,
          name: item.name,
          points: item.points,
          buttonText: item.isFollowing ? context.l10n.following : context.l10n.follow,
          isFollowing: item.isFollowing,
          onStoryTap: () {},
          onButtonPressed: () {},
        );
      },
    );
  }
}