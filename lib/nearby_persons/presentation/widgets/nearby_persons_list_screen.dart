import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/nearby/nearby_persons_list_tile.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class NearbyPersonsAndChatsListScreen extends StatelessWidget {
  final List nearbyPersons;
  final List chats;

  const NearbyPersonsAndChatsListScreen({
    super.key,
    required this.nearbyPersons,
    required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final TabController controller = DefaultTabController.of(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: AnimatedBuilder(
                animation: controller,
                builder: (_, __) {
                  return Text(
                    controller.index == 0
                        ? context.l10n.nearbyPersons
                        : context.l10n.chats,
                    style: AppTextStyles.titles.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  // ===== Tabs =====
                  Container(
                    padding: EdgeInsets.all(12.r),
                    child: TabBar(
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
                        Tab(text: context.l10n.nearbyPersons),
                        Tab(text: context.l10n.chats),
                      ],
                    ),
                  ),

                  // ===== Expandable Tab Views =====
                  Expanded(
                    child: TabBarView(
                      children: [
                        scrollableSearchAndList(context, nearbyPersons),
                        scrollableSearchAndList(context, chats),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ===== Search Bar & NearbyPersons/Chats List =====
  Widget scrollableSearchAndList(BuildContext context, List nearbyPersons) {
    return CustomScrollView(
      slivers: [
        // Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: AppTextFields(
              controller: SearchController(),
              hintText: context.l10n.searchHint,
              height: 56.h,
              contentPadding: EdgeInsets.all(18.r),
              icon: Icons.search,
              iconAtStart: false,
              iconColor: AppColors.turnbullBlue,
            ),
          ),
        ),

        // NearbyPersons/Chats List
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = nearbyPersons[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: NearbyPersonsListTile(
                story: item.story,
                name: item.name,
                miles: item.miles,
                isServiceProvider: item.isServiceProvider,
                onButtonPressed: () {},
                onStoryTap: () {},
              ),
            );
          }, childCount: nearbyPersons.length),
        ),
      ],
    );
  }
}
