import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/post_types/post_types.dart';
import 'package:traveller/core/constants/profile_settings/profile_settings_tile.dart';
import 'package:traveller/core/constants/text_area/text_area.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import '../../../add_types/presentation/screen/add_types.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/add_new_header/add_new_header.dart';

class AddNewTopic extends StatelessWidget{
  final String imageUrl;
  final String location;

  const AddNewTopic({
    super.key,
    required this.imageUrl,
    required this.location
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: "Add Topic",
        showBack: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            AddNewHeader(
              imageUrl: imageUrl,
              location: location,
              isEventPage: false,
            ),

            SizedBox(height: 20.h),

            TextArea(
              hintText: "Post title",
              height: 55.h,
            ),

            SizedBox(height: 10.h),

            TextArea(
              hintText: "Post but not less than 20 word",
              height: 135.h,
            ),

            SizedBox(height: 10.h),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: ProfileSettingsTile(
                icon: Image.asset("assets/images/icons/gate.png"),
                title: "Choose a gate",
                showDivider: false,
              ),
            ),

            SizedBox(height: 10.h),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.white,
              ),
              child: ProfileSettingsTile(
                icon: Image.asset("assets/images/icons/hashtag.png"),
                title: "Choose a type",
                showDivider: false,
                onTap: () {
                  context.push(
                      AppRoutes.addTypes,
                    extra: AddTypesArgs(
                        title: "Add Topic",
                        isEvent: false,
                      selectedIndex: 0
                    ),
                  );
                }
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TopicTypes(),
            SizedBox(height: 16.h),
            AppButton(
              text: "Post",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicTypes extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PostTypes(
            title: "Add Image",
            imageUrl: "assets/images/icons/image_icon.png",
            color: AppColors.turnbullBlue,
            onTap: (){}
        ),

        PostTypes(
            title: "Add Video",
            imageUrl: "assets/images/icons/video.png",
            color: AppColors.lebaneseRed,
            onTap: (){}
        ),

        PostTypes(
            title: "Add Poll",
            imageUrl: "assets/images/icons/poll.png",
            color: AppColors.darkYellow,
            onTap: (){}
        ),
      ],
    );
  }
}