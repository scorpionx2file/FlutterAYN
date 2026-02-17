import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../add_post_image_card/add_post_image_card.dart';

class MediaTextArea extends StatefulWidget {
  final String hintText;
  final double height;
  final TextEditingController? controller;

  const MediaTextArea({
    super.key,
    required this.hintText,
    required this.height,
    this.controller,
  });

  @override
  State<MediaTextArea> createState() => MediaTextAreaState();
}

class MediaTextAreaState extends State<MediaTextArea> {
  final List<File> mediaFiles = [];

  void addMedia(File file) {
    setState(() {
      mediaFiles.add(file);
    });
  }

  void _removeMedia(int index) {
    setState(() {
      mediaFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        width: double.infinity,
        height: widget.height,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: AppTextStyles.description.copyWith(
                    color: AppColors.spanishGrey,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),

            if (mediaFiles.isNotEmpty) ...[
              SizedBox(height: 8.h),
              SizedBox(
                height: 60.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: mediaFiles.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (_, index) {
                    return AddPostImageCard(
                      imagePath: mediaFiles[index].path,
                      onTap: () => _removeMedia(index),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}