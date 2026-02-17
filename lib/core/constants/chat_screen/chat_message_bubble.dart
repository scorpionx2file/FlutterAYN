import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../../../chat_screen/presentation/widgets/full_map_screen.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/fonts/app_text_styles.dart';
import '../../../core/utils/extensions/build_context_extensions.dart';

class ChatMessageBubble extends StatefulWidget {
  final String? message;
  final LatLng? location;
  final File? audioFile;
  final bool isMe;
  final String avatarUrl;
  final String time;
  final int? audioLength;

  const ChatMessageBubble({
    super.key,
    this.message,
    this.location,
    this.audioFile,
    required this.isMe,
    required this.avatarUrl,
    required this.time,
    this.audioLength
  });

  @override
  State<ChatMessageBubble> createState() => _ChatMessageBubbleState();
}

class _ChatMessageBubbleState extends State<ChatMessageBubble> {
  FlutterSoundPlayer? _player;
  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  Widget _buildAudioWave() {
    final audioSeconds = widget.audioLength ?? 0;
    final minutes = (audioSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (audioSeconds % 60).toString().padLeft(2, '0');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: widget.isMe ? AppColors.white : AppColors.black,
        ),
        SizedBox(width: 8.w),
        Row(
          children: List.generate(18, (i) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              width: 3.w,
              height: (i.isEven ? 18.h : 10.h),
              decoration: BoxDecoration(
                color: (widget.isMe ? Colors.white : Colors.black)
                    .withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        SizedBox(width: 8.w),
        Text(
          "$minutes:$seconds",
          style: TextStyle(
            color: widget.isMe ? AppColors.white : AppColors.black,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Future<void> _loadAudioDuration() async {
    if (_player == null) return;
    final info = await _player!.getProgress();
    if (info != null && mounted) {
      setState(() {
        duration = info['duration'] ?? Duration.zero;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.audioFile != null) {
      _player = FlutterSoundPlayer();
      _player!.openPlayer();
    }
  }

  @override
  void dispose() {
    _player?.closePlayer();
    _player = null;
    super.dispose();
  }

  void _toggleAudio() async {
    if (_player == null || widget.audioFile == null) return;

    if (isPlaying) {
      await _player!.pausePlayer();
      setState(() => isPlaying = false);
    } else {
      await _player!.startPlayer(
        fromURI: widget.audioFile!.path,
        codec: Codec.aacADTS,
        whenFinished: () {
          setState(() {
            isPlaying = false;
            position = Duration.zero;
          });
        },
      );

      _player!.setSubscriptionDuration(const Duration(milliseconds: 200));

      await _loadAudioDuration();

      _player!.onProgress!.listen((event) {
        if (mounted) {
          setState(() {
            position = event.position;
          });
        }
      });

      setState(() => isPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bubbleContent;

    if (widget.location != null) {
      // Existing location message code (unchanged)
      bubbleContent = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullMapScreen(location: widget.location!),
            ),
          );
        },
        child: Container(
          width: 0.7.sw,
          height: 190.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: Stack(
              children: [
                AbsorbPointer(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: widget.location!,
                      initialZoom: 15,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                        subdomains: ['a', 'b', 'c', 'd'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: widget.location!,
                            width: 48.w,
                            height: 48.h,
                            child: Icon(
                              Icons.location_pin,
                              size: 46.r,
                              color: AppColors.lebaneseRed,
                              shadows: [
                                Shadow(
                                  blurRadius: 8,
                                  color: AppColors.black.withOpacity(0.4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.black.withOpacity(0.25),
                        Colors.transparent,
                        AppColors.black.withOpacity(0.35),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 12.w,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: AppColors.white,
                          size: 14.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          context.l10n.location,
                          style: AppTextStyles.smallText.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  right: 12.w,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      context.l10n.tapToView,
                      style: AppTextStyles.smallText.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.audioFile != null) {
      // Audio message UI
      bubbleContent = GestureDetector(
        onTap: _toggleAudio,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: widget.isMe ? AppColors.turnbullBlue : AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: _buildAudioWave(),
      ),
      );
    } else {
      // Text message (unchanged)
      bubbleContent = Text(
        widget.message ?? '',
        textDirection: getTextDirection(widget.message ?? ''),
        style: AppTextStyles.description.copyWith(
          height: 1.4,
          color: widget.isMe ? AppColors.white : AppColors.black,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: Row(
        mainAxisAlignment:
        widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.isMe) ChatAvatar(widget.avatarUrl),
          if (!widget.isMe) SizedBox(width: 12.w),
          Flexible(
            child: Column(
              crossAxisAlignment: widget.isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: widget.location == null && widget.audioFile == null
                      ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h)
                      : EdgeInsets.zero,
                  decoration: widget.location == null && widget.audioFile == null
                      ? BoxDecoration(
                    color: widget.isMe ? AppColors.turnbullBlue : AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(widget.isMe ? 16.r : 4.r),
                      bottomRight: Radius.circular(widget.isMe ? 4.r : 16.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  )
                      : null,
                  child: bubbleContent,
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.time,
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.spanishGrey,
                  ),
                ),
              ],
            ),
          ),
          if (widget.isMe) SizedBox(width: 12.w),
          if (widget.isMe) ChatAvatar(widget.avatarUrl),
        ],
      ),
    );
  }

  TextDirection getTextDirection(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }
}

class ChatAvatar extends StatelessWidget {
  final String avatarUrl;

  const ChatAvatar(this.avatarUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24.r,
      backgroundImage: NetworkImage(avatarUrl),
    );
  }
}
