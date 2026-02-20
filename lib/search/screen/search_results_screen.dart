import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../widgets/search_results_app_bar.dart';
import '../widgets/search_bar_row.dart';
import '../widgets/search_category_tabs.dart';
import '../widgets/search_results_header.dart';
import '../widgets/people_results_list.dart';
import '../widgets/post_results_list.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({
    super.key,
    required this.initialQuery,
    required this.peopleFollowing,
    required this.peopleFollowers,
    required this.posts,
  });

  final String initialQuery;
  final List peopleFollowing;
  final List peopleFollowers;
  final List posts;

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _query;
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _query = TextEditingController(text: widget.initialQuery);
    _query.addListener(() => setState(() {}));

    _tabs = TabController(length: 4, vsync: this);
    _tabs.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _query.dispose();
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final peopleCount = computePeopleCount(
      query: _query.text,
      following: widget.peopleFollowing,
      followers: widget.peopleFollowers,
    );

    final postsCount = computePostsCount(
      query: _query.text,
      posts: widget.posts,
    );

    return Scaffold(
      appBar: SearchResultsAppBar(
        title: l10n.searchResultsTitle,
        onBack: () => context.pop(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchBarRow(
              controller: _query,
              selectedIndex: _tabs.index,
              onApplyFilter: (i) => _tabs.animateTo(i),
            ),

            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SearchCategoryTabs(
                        controller: _tabs,
                        tabs: [
                          l10n.tabPeople,
                          l10n.tabPlaces,
                          l10n.tabServices,
                          l10n.tabEvents,
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 8.h)),
                  SliverToBoxAdapter(
                    child: SearchResultsHeader(
                      leftText: '${l10n.searchResultsFor} "${_query.text}"',
                      rightText:
                      '${l10n.resultsCountPlaceholder}: ${peopleCount + postsCount}',
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 8.h)),
                ],
                body: TabBarView(
                  controller: _tabs,
                  children: [
                    PeopleResultsList(
                      key: const PageStorageKey('people_tab'),
                      query: _query.text,
                      following: widget.peopleFollowing,
                      followers: widget.peopleFollowers,
                    ),
                    PostResultsList(
                      key: const PageStorageKey('places_tab'),
                      query: _query.text,
                      posts: widget.posts,
                      onOpenPost: (id) => context.push('/post/$id'),
                    ),
                    PostResultsList(
                      key: const PageStorageKey('services_tab'),
                      query: _query.text,
                      posts: widget.posts,
                      onOpenPost: (id) => context.push('/post/$id'),
                    ),
                    PostResultsList(
                      key: const PageStorageKey('events_tab'),
                      query: _query.text,
                      posts: widget.posts,
                      onOpenPost: (id) => context.push('/post/$id'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int computePeopleCount({
  required String query,
  required List following,
  required List followers,
}) {
  final q = query.trim().toLowerCase();
  final all = [...following, ...followers];
  if (q.isEmpty) return all.length;

  return all.where((p) => (p.name as String).toLowerCase().contains(q)).length;
}

int computePostsCount({
  required String query,
  required List posts,
}) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return posts.length;

  return posts.where((p) {
    final h = p.headerData;
    final user = (h.username ?? "").toString().toLowerCase();
    final desc = (h.description ?? "").toString().toLowerCase();
    return user.contains(q) || desc.contains(q);
  }).length;
}