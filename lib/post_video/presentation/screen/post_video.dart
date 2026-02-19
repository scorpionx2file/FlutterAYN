import 'dart:io';
import 'package:flutter/material.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors/app_colors.dart';

class PostVideo extends StatefulWidget {
  final String videoPath;

  const PostVideo({
    super.key,
    required this.videoPath,
  });

  @override
  State<PostVideo> createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppHeader(title: context.l10n.addVideo),
      body: _controller.value.isInitialized
          ? Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),

          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightGreen,
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: () {},
              child: Text(context.l10n.postVideo),
            ),
          ),
        ],
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}