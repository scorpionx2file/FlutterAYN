import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/stories/presentation/widgets/story_bottom_bar.dart';
import 'package:traveller/stories/presentation/widgets/story_divider.dart';
import 'package:traveller/stories/presentation/widgets/story_header.dart';
import 'package:video_player/video_player.dart';
import '../../../core/constants/story_item/story_item.dart';


class StoryScreen extends StatefulWidget {
  final List<Story> stories;

  const StoryScreen({
    super.key,
    required this.stories,
  });

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with SingleTickerProviderStateMixin{
  int currentIndex = 0;
  late AnimationController _progressController;
  late Animation<double> _progress;
  VideoPlayerController? _videoController;

  bool _isVideo(String url) {
    return url.toLowerCase().endsWith('.mp4') ||
        url.toLowerCase().endsWith('.mov') ||
        url.toLowerCase().endsWith('.webm');
  }

  void _nextStory() {
    if (currentIndex < widget.stories.length - 1) {
      setState(() => currentIndex++);
      _loadStory();
    } else {
      Navigator.pop(context);
    }
  }

  Duration get _storyDuration {
    final story = widget.stories[currentIndex];
    if (_isVideo(story.data)) {
      return _videoController?.value.duration ?? const Duration(seconds: 10);
    }
    return const Duration(seconds: 15);
  }

  Future<void> _loadStory() async {
    final story = widget.stories[currentIndex];

    _progressController.stop();
    _progressController.reset();

    if (_videoController != null) {
      await _videoController!.pause();
      await _videoController!.dispose();
      _videoController = null;
    }

    if (_isVideo(story.data)) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(story.data));

      await _videoController!.initialize();

      if (!mounted) return;

      setState(() {});

      await _videoController!.play();
      _progressController.duration = _videoController!.value.duration;
    }
    else {
      _progressController.duration = const Duration(seconds: 15);
    }

    _progressController.forward();
  }

  void _pauseStory() {
    _progressController.stop();
    _videoController?.pause();
  }

  void _resumeStory() {
    if (!_progressController.isAnimating) {
      _progressController.forward();
    }
    _videoController?.play();
  }

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(vsync: this);
    _progress = Tween<double>(begin: 0, end: 1).animate(_progressController)
      ..addListener(() {
        if (mounted) setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _nextStory();
        }
      });

    _loadStory();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isVideo = _isVideo(widget.stories[currentIndex].data);
    final image = isVideo ? null : widget.stories[currentIndex].data;

    return Stack(
      children: [
        Positioned.fill(
          child: _buildBackground(
            key: ValueKey(_videoController),
            data: image,
            controller: _videoController,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: AppColors.black.withOpacity(0.3),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              StoryHeader(
                imageUrl: widget.stories[currentIndex].imageUrl,
                username: widget.stories[currentIndex].username!,
                location: "Cairo, Egypt",
              ),
              StoryDivider(
                storyNumbers: widget.stories.length,
                currentIndex: currentIndex,
                progress: _progress.value,
              ),
              const Spacer(),
              Column(
                children: [
                  Image.asset("assets/images/icons/logo.png"),
                  SizedBox(height: 10.h),
                  StoryBottomBar(),
                ],
              ),
            ],
          ),
        ),

        // Overlay taps + hold
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,

            onLongPressStart: (_) => _pauseStory(),
            onLongPressEnd: (_) => _resumeStory(),

            child: Row(
              children: [
                // Left half → previous story
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (currentIndex > 0) {
                        setState(() => currentIndex--);
                        _loadStory();
                      }
                    },
                  ),
                ),

                // Right half → next story
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _nextStory,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _buildBackground extends StatelessWidget {
  final String? data;
  final VideoPlayerController? controller;

  const _buildBackground({
    super.key,
    this.data,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Image.network(
        data!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (controller == null) return const SizedBox();

    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller!,
      builder: (context, VideoPlayerValue value, child) {
        if (!value.isInitialized) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: value.size.width,
            height: value.size.height,
            child: VideoPlayer(controller!),
          ),
        );
      },
    );
  }
}