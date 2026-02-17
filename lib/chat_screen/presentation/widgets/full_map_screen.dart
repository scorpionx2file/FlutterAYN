import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class FullMapScreen extends StatelessWidget {
  final LatLng location;
  const FullMapScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: location,
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
                point: location,
                width: 40.w,
                height: 40.h,
                child: Icon(
                  Icons.location_on,
                  size: 40.r,
                  color: AppColors.lebaneseRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
