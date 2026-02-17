import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../chat_screen/presentation/widgets/full_map_screen.dart';

enum ChatMessageType { text, location }

class ChatMessage {
  final ChatMessageType type;
  final String? text;
  final LatLng? location;
  final bool isMe;
  final String avatarUrl;
  final String time;

  ChatMessage({
    required this.type,
    this.text,
    this.location,
    required this.isMe,
    required this.avatarUrl,
    required this.time,
  });
}

class ChatMessageBubble extends StatelessWidget {
  final String? message;
  final LatLng? location;
  final bool isMe;
  final String avatarUrl;
  final String time;

  const ChatMessageBubble({
    super.key,
    this.message,
    this.location,
    required this.isMe,
    required this.avatarUrl,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    Widget bubbleContent;

    if (location != null) {
      /// ENHANCED LOCATION MESSAGE UI
      bubbleContent = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullMapScreen(location: location!),
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
                /// Mini Map (non-interactive)
                AbsorbPointer(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: location!,
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
                            point: location!,
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

                /// Gradient overlay
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

                /// Location label
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

                /// Tap hint
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
    } else {
      /// TEXT MESSAGE
      bubbleContent = Text(
        message ?? '',
        textDirection: getTextDirection(message ?? ''),
        style: AppTextStyles.description.copyWith(
          height: 1.4,
          color: isMe ? AppColors.white : AppColors.black,
          decoration: message?.startsWith('https://') ?? false
              ? TextDecoration.underline
              : TextDecoration.none,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: Row(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ChatAvatar(avatarUrl),
          if (!isMe) SizedBox(width: 12.w),
          Flexible(
            child: Column(
              crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: location == null
                      ? EdgeInsets.symmetric(
                      horizontal: 14.w, vertical: 10.h)
                      : EdgeInsets.zero,
                  decoration: location == null
                      ? BoxDecoration(
                    color:
                    isMe ? AppColors.turnbullBlue : AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft:
                      Radius.circular(isMe ? 16.r : 4.r),
                      bottomRight:
                      Radius.circular(isMe ? 4.r : 16.r),
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
                  time,
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.spanishGrey,
                  ),
                ),
              ],
            ),
          ),
          if (isMe) SizedBox(width: 12.w),
          if (isMe) ChatAvatar(avatarUrl),
        ],
      ),
    );
  }

  TextDirection getTextDirection(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text)
        ? TextDirection.rtl
        : TextDirection.ltr;
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
