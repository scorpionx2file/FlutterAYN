import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import '../../theme/colors/app_colors.dart';

class AddNewBuildMap extends StatelessWidget{
  final LatLng selectedLocation;
  final ValueChanged<LatLng> onLocationChanged;

  const AddNewBuildMap({
    super.key,
    required this.selectedLocation,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onLocationChanged(point);
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
    );
  }
}