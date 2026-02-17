import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../../../core/utils/location/location_picker_bottom_sheet.dart';


class ChatInputBar extends StatelessWidget {
  final void Function(String) onSendMessage;
  final void Function(LatLng) onSendLocation;

  const ChatInputBar({
    super.key,
    required this.onSendMessage,
    required this.onSendLocation,
  });

  Future<Position?> requestLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 72.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.send, size: 22.sp, color: AppColors.turnbullBlue),
            onPressed: () {
              final text = textController.text.trim();
              if (text.isNotEmpty) {
                onSendMessage(text);
                textController.clear();
              }
            },
          ),
          Container(
            width: 1.w,
            height: 28.h,
            color: AppColors.spanishGrey.withOpacity(0.4),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt_outlined,
                size: 22.sp, color: AppColors.spanishGrey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.mic_none_outlined,
                size: 22.sp, color: AppColors.spanishGrey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.location_on_outlined,
                size: 22.sp, color: AppColors.spanishGrey),
            onPressed: () async {
              final position = await requestLocationPermission();
              if (position == null) return;

              final initialLatLng =
              LatLng(position.latitude, position.longitude);

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(16))),
                builder: (_) => LocationPickerBottomSheet(
                  initialPosition: initialLatLng,
                  onSend: onSendLocation,
                ),
              );
            },
          ),
          Expanded(
            child: TextField(
              controller: textController,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: "Write your message here",
                hintStyle:
                AppTextStyles.description.copyWith(color: AppColors.spanishGrey),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
