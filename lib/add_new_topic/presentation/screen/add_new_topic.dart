import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/constants/text_area/text_area.dart';
import '../../../add_types/presentation/screen/add_types.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/add_new_bottom_bar/add_new_bottom_bar.dart';
import '../../../core/constants/add_new_header/add_new_header.dart';
import '../../../core/constants/add_new_post_option_tile/add_new_post_option_tile.dart';
import '../../../core/constants/media_text_area/media_text_area.dart';
import '../../../core/constants/post_types/post_types.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/utils/media_picker/media_picker.dart';

class AddNewTopic extends StatefulWidget {
  final String imageUrl;
  final String location;

  const AddNewTopic({
    super.key,
    required this.imageUrl,
    required this.location
  });

  @override
  State<AddNewTopic> createState() => _AddNewTopicState();
}

class _AddNewTopicState extends State<AddNewTopic> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  final GlobalKey<MediaTextAreaState> mediaKey = GlobalKey<MediaTextAreaState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Add Topic", showBack: true),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            AddNewHeader(
              imageUrl: widget.imageUrl,
              location: widget.location,
              isEventPage: false,
            ),
            SizedBox(height: 20.h),
            TextArea(
              hintText: "Post title",
              height: 55.h,
              controller: titleController,
            ),
            SizedBox(height: 10.h),
            MediaTextArea(
              key: mediaKey,
              hintText: "Post but not less than 20 words",
              height: 135.h,
              controller: bodyController,
            ),
            SizedBox(height: 10.h),
            AddNewPostOptionTile(
                icon: Image.asset("assets/images/icons/gate.png"),
                title: "Choose a gate",
                showDivider: false,
                onTap: () {}),
            SizedBox(height: 10.h),
            AddNewPostOptionTile(
              icon: Image.asset("assets/images/icons/hashtag.png"),
              title: "Choose a type",
              showDivider: false,
              onTap: () {
                context.push(
                  AppRoutes.addTypes,
                  extra: AddTypesArgs(title: "Add Topic", isEvent: false, selectedIndex: 0),
                );
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
      bottomNavigationBar: AddNewBottomBar(
        text: "Post",
        onTap: () {
          final text = bodyController.text.trim();
          final wordCount = text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
          if (wordCount < 20) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Post must be at least 20 words")),
            );
            return;
          }
        },
        showTypes: true,
        items: [
          PostTypeItem(
            title: "Add Image",
            imageUrl: "assets/images/icons/image_icon.png",
            color: AppColors.turnbullBlue,
            onTap: () async {
              bool granted = await MediaPicker.requestPermissions();
              if (!granted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Permission denied. Please enable in settings.")),
                );
                return;
              }

              final file = await MediaPicker.pickImage();
              if (file != null) mediaKey.currentState?.addMedia(file);
            },
          ),

          PostTypeItem(
            title: "Add Video",
            imageUrl: "assets/images/icons/video.png",
            color: AppColors.lebaneseRed,
            onTap: () async {
              bool granted = await MediaPicker.requestPermissions();
              if (!granted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Permission denied")),
                );
                return;
              }

              final file = await MediaPicker.pickVideo();
              if (file != null) mediaKey.currentState?.addMedia(file);
            },
          ),

          PostTypeItem(
            title: "Add Poll",
            imageUrl: "assets/images/icons/poll.png",
            color: AppColors.darkYellow,
            onTap: () {
              context.push(AppRoutes.addPoll);
            },
          ),
        ],
      ),
    );
  }
}