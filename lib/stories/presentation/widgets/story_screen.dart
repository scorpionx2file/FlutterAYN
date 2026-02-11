import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/stories/presentation/widgets/story_bottom_bar.dart';
import 'package:traveller/stories/presentation/widgets/story_divider.dart';
import 'package:traveller/stories/presentation/widgets/story_header.dart';
import 'package:video_player/video_player.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/story_item/story_item.dart';

class StoryScreen extends StatefulWidget {
  final List<List<Story>> allStories;
  final int personIndex;
  final int startStoryIndex;

  const StoryScreen({
    super.key,
    required this.allStories,
    required this.personIndex,
    this.startStoryIndex = 0,
  });

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with SingleTickerProviderStateMixin{
  int currentIndex = 0;
  late List<Story> stories;
  final GlobalKey _headerKey = GlobalKey();
  late AnimationController _progressController;
  late Animation<double> _progress;
  late int currentPersonIndex;
  VideoPlayerController? _videoController;
  bool _isNavigating = false;
  late final AnimationStatusListener _onAnimationComplete;
  final FocusNode _messageFocusNode = FocusNode();
  final Map<String, String> _storyDrafts = {};
  final TextEditingController _messageController = TextEditingController();
  void _closeKeyboardAndResume() {
    FocusScope.of(context).unfocus();
    _resumeStory();
  }
  double get _bottomBarHeight => 90.h;

  bool _isVideo(String url) {
    return url.toLowerCase().endsWith('.mp4') ||
        url.toLowerCase().endsWith('.mov') ||
        url.toLowerCase().endsWith('.webm');
  }

  double get _headerHeight {
    final box = _headerKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.size.height ?? 100.h;
  }

  void _nextStory() {
    if (_isNavigating) return;

    if (currentIndex < stories.length - 1) {
      _saveCurrentDraft();
      setState(() => currentIndex++);
      _loadStory();
    } else {
      _nextPersonInternal();
    }
  }

  void _goToPreviousStory() {
    if (_isNavigating) return;

    if (currentIndex > 0) {
      _saveCurrentDraft();
      setState(() => currentIndex--);
      _loadStory();
    } else {
      _previousPersonInternal();
    }
  }

  Future<void> _loadStory() async {
    final story = stories[currentIndex];
    final storyKey = story.id;

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

      if (!mounted || stories[currentIndex].id != storyKey) return;

      final duration = _videoController!.value.duration;
      _progressController.duration =
      (duration.inMilliseconds > 0)
          ? duration
          : const Duration(seconds: 10);

      setState(() {});
      await _videoController!.play();
    } else {
      _progressController.duration = const Duration(seconds: 15);
    }

    _progressController.forward();

    if (stories[currentIndex].id == storyKey) {
      _messageController.text = _storyDrafts[storyKey] ?? "";
    }
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

  void _nextPersonInternal() {
    if (currentPersonIndex < widget.allStories.length - 1) {
      setState(() {
        currentPersonIndex++;
        stories = widget.allStories[currentPersonIndex];
        currentIndex = 0;
        _isNavigating = false;
      });
      _loadStory();
    } else {
      context.go(AppRoutes.home);
    }
  }

  void _previousPersonInternal() {
    if (currentPersonIndex > 0) {
      setState(() {
        currentPersonIndex--;
        stories = widget.allStories[currentPersonIndex];
        currentIndex = stories.length - 1;
        _isNavigating = false;
      });
      _loadStory();
    } else {
      context.go(AppRoutes.home);
    }
  }

  void _saveCurrentDraft() {
    final story = stories[currentIndex];
    final key = story.id;
    _storyDrafts[key] = _messageController.text;
  }

  void _sendMessage() {
    final story = stories[currentIndex];
    final key = story.id;
    _storyDrafts.remove(key);
    _messageController.clear();
  }

  @override
  void initState() {
    super.initState();

    _isNavigating = false;
    currentPersonIndex = widget.personIndex;
    stories = widget.allStories[currentPersonIndex];
    currentIndex = widget.startStoryIndex;

    _progressController = AnimationController(vsync: this);

    _onAnimationComplete = (status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    };

    _progress = Tween<double>(begin: 0, end: 1).animate(_progressController)
      ..addListener(() {
        if (mounted) setState(() {});
      })
      ..addStatusListener(_onAnimationComplete);

    _loadStory();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    _progressController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isVideo = _isVideo(stories[currentIndex].data);
    final image = isVideo ? null : stories[currentIndex].data;

    return Scaffold(
      body: Stack(
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
                  key: _headerKey,
                  imageUrl: stories[currentIndex].imageUrl,
                  username: stories[currentIndex].username!,
                  location: "Cairo, Egypt",
                  onTap: () => context.go(AppRoutes.home),
                ),
                StoryDivider(
                  storyNumbers: stories.length,
                  currentIndex: currentIndex,
                  progress: _progress.value,
                ),
                const Spacer(),
                Column(
                  children: [
                    Image.asset("assets/images/icons/logo.png"),
                    SizedBox(height: 10.h),
                    StoryBottomBar(
                      focusNode: _messageFocusNode,
                      onFocus: _pauseStory,
                      onUnfocus: _resumeStory,
                      controller: _messageController
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (_messageFocusNode.hasFocus)
            Positioned(
              top: _headerHeight,
              left: 0,
              right: 0,
              bottom: _bottomBarHeight,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeKeyboardAndResume,
              ),
            ),

          Positioned(
            top: _headerHeight,
            left: 0,
            right: 0,
            bottom: _bottomBarHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onLongPressStart: (_) => _pauseStory(),
              onLongPressEnd: (_) => _resumeStory(),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _goToPreviousStory,
                    ),
                  ),
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
      ),
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