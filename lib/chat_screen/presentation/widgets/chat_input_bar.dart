import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/utils/helper/location.dart';
import '../../../core/utils/location/location_picker_bottom_sheet.dart';
import 'package:geolocator/geolocator.dart';

class ChatInputBar extends StatelessWidget {
  final void Function(String message) onSendMessage;

  const ChatInputBar({super.key, required this.onSendMessage});


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
          // SEND TEXT MESSAGE
          IconButton(
            icon: Icon(
              Icons.send,
              size: 22.sp,
              color: AppColors.turnbullBlue,
            ),
            onPressed: () {
              final text = textController.text.trim();
              if (text.isNotEmpty) {
                onSendMessage(text);
                textController.clear();
              }
            },
          ),

          // DIVIDER
          Container(
            width: 1.w,
            height: 28.h,
            color: AppColors.spanishGrey.withOpacity(0.4),
          ),

          // CAMERA
          IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () {},
          ),

          // MICROPHONE
          IconButton(
            icon: Icon(
              Icons.mic_none_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () {},
          ),

          // LOCATION
          IconButton(
            icon: Icon(
              Icons.location_on_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () async {
              final position = await requestLocationPermission();

              if (position == null) {
                // You can show a snackbar or dialog here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Location permission denied")),
                );
                return;
              }

              final initialLatLng =
              LatLng(position.latitude, position.longitude);

              if (!context.mounted) return;

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                builder: (_) {
                  return LocationPickerBottomSheet(
                    initialPosition: initialLatLng,
                    onSend: (locationUrl) {
                      onSendMessage(locationUrl);
                    },
                  );
                },
              );
            },
          ),

          // INPUT FIELD
          Expanded(
            child: TextField(
              controller: textController,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: context.l10n.writeYourMessageHere,
                hintStyle: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey,
                ),
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