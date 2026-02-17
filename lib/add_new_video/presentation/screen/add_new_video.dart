import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/constants/add_new_header/add_new_header.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../add_types/presentation/screen/add_types.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/add_new_bottom_bar/add_new_bottom_bar.dart';
import '../../../core/constants/add_new_build_map/add_new_build_map.dart';
import '../../../core/constants/add_new_post_option_tile/add_new_post_option_tile.dart';
import '../../../core/constants/text_area/text_area.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/utils/location/location_service.dart';
import '../../../core/utils/media_picker/media_picker.dart';

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
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    final current = await LocationService.getCurrentLatLng();
    if (current != null && mounted) {
      setState(() {
        selectedLocation = current;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: context.l10n.addVideo,
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
              hintText: context.l10n.videoTitle,
              height: 55.h,
            ),

            SizedBox(height: 10.h),

            AddNewPostOptionTile(
              icon: Image.asset("assets/images/icons/gate.png"),
              title: context.l10n.chooseAGate,
              showDivider: false,
              onTap: (){}
            ),

            SizedBox(height: 10.h),

            AddNewPostOptionTile(
              icon: Image.asset("assets/images/icons/hashtag.png"),
              title: context.l10n.chooseAType,
              showDivider: false,
              onTap: (){
                context.push(
                  AppRoutes.addTypes,
                  extra: AddTypesArgs(
                      title: context.l10n.addVideo,
                      isEvent: false,
                      selectedIndex: 0
                  ),
                );
              },
            ),

            SizedBox(height: 10.h),

            selectedLocation == null
                ? const Center(child: CircularProgressIndicator())
                : AddNewBuildMap(
              selectedLocation: selectedLocation!,
              onLocationChanged: (newLocation) {
                setState(() {
                  selectedLocation = newLocation;
                });
              },
            ),
          ],
        ),
      ),

        bottomNavigationBar: AddNewBottomBar(
          text: context.l10n.postVideo,
          onTap: () async {
            final file = await MediaPicker.recordVideoFromCamera();
            if (file != null) {
              print("Video path: ${file.path}");
            }
          },
          showSwitch: true,
          switchTitle: context.l10n.saveVideoInGallery,
          icon: Icon(
            Icons.videocam,
            color: AppColors.white,
          ),
        )
    );
  }
}