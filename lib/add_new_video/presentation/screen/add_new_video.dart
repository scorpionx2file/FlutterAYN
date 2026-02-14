import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/constants/add_new_header/add_new_header.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/constants/option_switch/option_switch.dart';
import '../../../core/constants/button/app_button.dart';
import '../../../core/constants/profile_settings/profile_settings_tile.dart';
import '../../../core/constants/text_area/text_area.dart';
import '../../../core/theme/colors/app_colors.dart';

class AddNewVideo extends StatefulWidget {
  final String imageUrl;
  final String location;

  const AddNewVideo({
    super.key,
    required this.imageUrl,
    required this.location,
  });

  @override
  State<AddNewVideo> createState() => _AddNewVideoState();
}


class _AddNewVideoState extends State<AddNewVideo> {
  LatLng selectedLocation = LatLng(50.0, 10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: "Add Video",
        showBack: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            AddNewHeader(
                imageUrl: widget.imageUrl,
                location: widget.location,
                isEventPage: false
            ),

            SizedBox(height: 20.h),

            TextArea(
              hintText: "Video title",
              height: 55.h,
            ),

            SizedBox(height: 10.h),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: ProfileSettingsTile(
                icon: Image.asset("assets/images/icons/gate.png"),
                title: "Choose a gate",
                showDivider: false,
              ),
            ),

            SizedBox(height: 10.h),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.white,
              ),
              child: ProfileSettingsTile(
                icon: Image.asset("assets/images/icons/hashtag.png"),
                title: "Choose a type",
                showDivider: false,
              ),
            ),

            SizedBox(height: 10.h),

            Container(
              height: 135.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: selectedLocation,
                    initialZoom: 5,
                    onTap: (tapPosition, point) {
                      setState(() {
                        selectedLocation = point;
                      });
                    },
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
                          point: selectedLocation,
                          width: 40,
                          height: 40,
                          alignment: Alignment.topCenter,
                          child: Icon(
                            Icons.location_pin,
                            color: AppColors.turnbullBlue,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),

        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OptionSwitch(
              title: 'Save video in gallery',
              value: true,
                onChanged: (bool value) {  },
              ),
              SizedBox(height: 16.h),
              AppButton(
                text: "Post Video",
                icon: Icon(
                  Icons.videocam,
                  color: AppColors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        )
    );
  }
}