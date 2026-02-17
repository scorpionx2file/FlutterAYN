import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class LocationPickerBottomSheet extends StatefulWidget {
  final LatLng initialPosition;
  final void Function(LatLng location) onSend;

  const LocationPickerBottomSheet({
    super.key,
    required this.initialPosition,
    required this.onSend,
  });

  @override
  State<LocationPickerBottomSheet> createState() =>
      _LocationPickerBottomSheetState();
}

class _LocationPickerBottomSheetState extends State<LocationPickerBottomSheet> {
  late LatLng selectedLatLng;

  @override
  void initState() {
    super.initState();
    selectedLatLng = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: selectedLatLng,
                initialZoom: 15,
                onTap: (tapPosition, latLng) {
                  setState(() {
                    selectedLatLng = latLng;
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
                      point: selectedLatLng,
                      width: 36.w,
                      height: 36.h,
                      child: Icon(
                        Icons.location_on,
                        size: 36.r,
                        color: AppColors.lebaneseRed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                height: 32.h,
                text: 'Send Location',
                onPressed: () {
                  widget.onSend(selectedLatLng);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
