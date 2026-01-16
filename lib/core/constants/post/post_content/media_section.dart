import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/video/presentation/widgets/multi_media_row_controller.dart';

class MediaSection extends StatefulWidget {
  final List<String> mediaUrls;
  final bool isVideoScreen;

  const MediaSection({
    super.key,
    required this.mediaUrls,
    required this.isVideoScreen,
  });

  @override
  State<MediaSection> createState() => _MediaSectionState();
}

class _MediaSectionState extends State<MediaSection> {
  int _currentIndex = 0;

  void _next() {
    if (_currentIndex < widget.mediaUrls.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _previous() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isVideoScreen
        ? _singleMediaView()
        : _pageViewMedia();
  }

  // VIDEO SCREEN VIEW
  Widget _singleMediaView() {
    final url = widget.mediaUrls[_currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 220.h,
          width: double.infinity,
          child: _buildMedia(url),
        ),

        SizedBox(height: 12.h),

        MultiMediaRowController(
          currentIndex: _currentIndex,
          total: widget.mediaUrls.length,
          onPrevious: _currentIndex > 0 ? _previous : null,
          onNext: _currentIndex < widget.mediaUrls.length - 1 ? _next : null,
        ),
      ],
    );
  }

  // HOME SCREEN VIEW (UNCHANGED)
  Widget _pageViewMedia() {
    return SizedBox(
      height: 200.h,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: widget.mediaUrls.length,
        itemBuilder: (context, index) {
          final url = widget.mediaUrls[index];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: _buildMedia(url),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMedia(String url) {
    if (_isVideo(url)) {
      return Container(
        color: AppColors.black,
        child: const Center(
          child: Icon(
            Icons.play_circle_fill,
            color: AppColors.white,
            size: 56,
          ),
        ),
      );
    }

    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => Container(
        color: AppColors.spanishGrey,
        child: const Icon(Icons.broken_image),
      ),
    );
  }

  bool _isVideo(String url) {
    return url.endsWith('.mp4') ||
        url.endsWith('.mov') ||
        url.endsWith('.webm');
  }
}

