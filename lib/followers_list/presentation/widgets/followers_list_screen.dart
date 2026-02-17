import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../core/constants/followers_list/followers_list_tile.dart';

class FollowersListScreen extends StatefulWidget {
  final List following;
  final List followers;

  const FollowersListScreen({
    super.key,
    required this.following,
    required this.followers,
  });

  @override
  State<FollowersListScreen> createState() => _FollowersListScreenState();
}

class _FollowersListScreenState extends State<FollowersListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List get filteredFollowing => widget.following
      .where((p) => p.name.toLowerCase().contains(_searchController.text.toLowerCase()))
      .toList();

  List get filteredFollowers => widget.followers
      .where((p) => p.name.toLowerCase().contains(_searchController.text.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AnimatedBuilder(
          animation: _tabController,
          builder: (_, __) {
            return Text(
              _tabController.index == 0
                  ? context.l10n.following
                  : context.l10n.followers,
              style: AppTextStyles.titles.copyWith(fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // ===== Tabs =====
          Container(
            padding: EdgeInsets.all(12.r),
            child: TabBar(
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppColors.turnbullBlue,
                  width: 3.h,
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.turnbullBlue,
              unselectedLabelColor: Colors.grey,
              labelStyle: AppTextStyles.title.copyWith(fontSize: 16.sp),
              tabs: [
                Tab(text: context.l10n.following),
                Tab(text: context.l10n.followers),
              ],
            ),
          ),

          // ===== Search Bar =====
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: AppTextFields(
              controller: _searchController,
              hintText: context.l10n.searchHint,
              height: 56.h,
              contentPadding: EdgeInsets.all(18.r),
              icon: Icons.search,
              iconAtStart: false,
              iconColor: AppColors.turnbullBlue,
            ),
          ),

          // ===== Tab Views =====
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildFollowingOrFollowersList(filteredFollowing),
                buildFollowingOrFollowersList(filteredFollowers),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFollowingOrFollowersList(List people) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      itemCount: people.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final item = people[index];
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

