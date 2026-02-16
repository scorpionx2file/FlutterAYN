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

            TextArea(
              hintText: "Post but not less than 20 word",
              height: 135.h,
              controller: bodyController,
            ),

            SizedBox(height: 10.h),

            AddNewPostOptionTile(
              icon: Image.asset("assets/images/icons/gate.png"),
              title: "Choose a gate",
              showDivider: false,
              onTap: (){}
            ),

            SizedBox(height: 10.h),

            AddNewPostOptionTile(
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

            SizedBox(height: 30.h),
          ],
        ),
      ),

        bottomNavigationBar: AddNewBottomBar(
          text: "Post",
          onTap: () {
            final text = bodyController.text.trim();
            final wordCount = text
                .split(RegExp(r'\s+'))
                .where((w) => w.isNotEmpty)
                .length;

            if (wordCount < 20) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Post must be at least 20 words"),
                ),
              );
              return;
            }
          },
        )
        );
  }
}