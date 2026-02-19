import 'dart:io';
import 'package:flutter/material.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:video_player/video_player.dart';
import '../widgets/chat_input_bar.dart';

class FullMediaScreen extends StatefulWidget {
  final File file;
  final MediaType type;

  const FullMediaScreen({super.key, required this.file, required this.type});

  @override
  State<FullMediaScreen> createState() => _FullMediaScreenState();
}

class _FullMediaScreenState extends State<FullMediaScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.type == MediaType.video) {
      _controller = VideoPlayerController.file(widget.file)
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: widget.type == MediaType.image
              ? Image.file(widget.file, fit: BoxFit.contain)
              : _controller != null && _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
