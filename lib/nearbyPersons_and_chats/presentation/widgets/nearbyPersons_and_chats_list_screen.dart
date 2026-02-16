import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:traveller/core/constants/nearby/nearby_persons_list_tile.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/chats/chat_tile.dart';

class NearbyPersonsAndChatsListScreen extends StatefulWidget {
  final List<ChatTileModel> chats;
  final List<NearbyPersonModel> nearbyPersons;

  const NearbyPersonsAndChatsListScreen({
    super.key,
    required this.chats,
    required this.nearbyPersons,
  });

  @override
  State<NearbyPersonsAndChatsListScreen> createState() =>
      _NearbyPersonsAndChatsListScreenState();
}

class _NearbyPersonsAndChatsListScreenState
    extends State<NearbyPersonsAndChatsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() => setState(() {})); // Update filter dynamically
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<ChatTileModel> get filteredChats => widget.chats
      .where((c) =>
      c.chatName.toLowerCase().contains(_searchController.text.toLowerCase()))
      .toList();

  List<NearbyPersonModel> get filteredNearby => widget.nearbyPersons
      .where((p) =>
      p.name.toLowerCase().contains(_searchController.text.toLowerCase()))
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
                  ? context.l10n.chats
                  : context.l10n.nearbyPersons,
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
              unselectedLabelColor: AppColors.spanishGrey,
              labelStyle: AppTextStyles.title.copyWith(fontSize: 16.sp),
              tabs: [
                Tab(text: context.l10n.chats),
                Tab(text: context.l10n.nearbyPersons),
              ],
            ),
          ),

          // ===== Search Bar (under tabs) =====
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
                buildChatsList(filteredChats),
                buildNearbyPersonsList(filteredNearby),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNearbyPersonsList(List<NearbyPersonModel> nearbyPersons) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      itemCount: nearbyPersons.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final item = nearbyPersons[index];
        return NearbyPersonsListTile(
          story: item.story,
          name: item.name,
          miles: item.miles,
          isServiceProvider: item.isServiceProvider,
          onButtonPressed: () {},
          onStoryTap: () {},
        );
      },
    );
  }

  Widget buildChatsList(List<ChatTileModel> chats) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      itemCount: chats.length,
      separatorBuilder: (_, __) => SizedBox(height: 6.h),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return Slidable(
          key: ValueKey(chat.chatName),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              // ===== Mute / Unmute Action =====
              SlidableAction(
                onPressed: (_) {
                  setState(() {
                    chat.isMuted = !chat.isMuted; // toggle mute state
                  });
                },
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.black,
                icon: chat.isMuted ? Icons.volume_up : Icons.volume_off,
                label: chat.isMuted ? 'Unmute' : 'Mute',
              ),
              // ===== Delete Action =====
              SlidableAction(
                onPressed: (_) {
                  setState(() {
                    widget.chats.removeAt(index); // remove chat
                  });
                },
                backgroundColor: AppColors.lebaneseRed,
                foregroundColor: AppColors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ChatTile(
            chatModel: chat,
            onTap: () {},
            // Show mute icon on tile if chat.isMuted
          ),
        );
      },
    );
  }
}
