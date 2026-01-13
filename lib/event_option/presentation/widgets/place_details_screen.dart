
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/event_option/presentation/widgets/bottom_section/bottom_section_tabs.dart';
import 'package:traveller/event_option/presentation/widgets/bottom_section/event_list.dart';
import 'package:traveller/event_option/presentation/widgets/content_section/content_section.dart';

import '../../../core/constants/event_options/event_options_posts/event_options_posts.dart';
import 'header_setion/header_section.dart';

class PlaceInfoModel{
  final String gateName;
  final PlaceContent placeContent;


  PlaceInfoModel({
    required this.gateName,
    required this.placeContent,
  });
}

class PlaceDetailsScreen extends StatelessWidget {
  final PlaceInfoModel placeInfo;
  final List<EventPostsData> posts;

  const PlaceDetailsScreen({
    super.key, required this.placeInfo, required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // ===== IMAGE BACKGROUND =====
          SizedBox(
            height: 1.sh,   // 👈 screen height
            width: 1.sw,   // 👈 screen width
            child: Image.network(
              "https://cdn.britannica.com/99/116199-050-FC94F813/Temple-of-Seti-I-Abydos-Egypt.jpg",
              fit: BoxFit.fill,
            ),
          ),

          // ===== SHADOW =====
          Container(
            height: 450.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.45),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // ===== HEADER =====
          Positioned(
            top: 30.h,
            right: 15.w,
            child: HeaderSection(gateName: placeInfo.gateName),
          ),

          // ===== CONTENT OVER IMAGE =====
          Positioned(
            left: 0,
            right: 0,
            top: 150.h,
            child: ContentSection(placeContent: placeInfo.placeContent),
          ),

          // ===== WHITE SECTION OVER IMAGE =====
          Positioned(
            top: 320.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  BottomSectionTabs(),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: EventList(posts: posts),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}



