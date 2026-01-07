import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class MediaSection extends StatelessWidget {
  final List<String> mediaUrls;

  const MediaSection({
    super.key,
    required this.mediaUrls,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: mediaUrls.length,
        itemBuilder: (context, index) {
          final url = mediaUrls[index];

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
      return _videoPlaceholder();
    }

    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => _mediaPlaceholder(),
    );
  }

  bool _isVideo(String url) {
    return url.toLowerCase().endsWith('.mp4') ||
        url.toLowerCase().endsWith('.mov') ||
        url.toLowerCase().endsWith('.webm');
  }

  Widget _videoPlaceholder() {
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

  Widget _mediaPlaceholder() {
    return Container(
      color: AppColors.spanishGrey,
      child: const Icon(Icons.broken_image),
    );
  }
}