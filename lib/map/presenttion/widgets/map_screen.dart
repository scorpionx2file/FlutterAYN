import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/colors/app_colors.dart';
import 'map_pin.dart';
import 'map_search_bar.dart';
import 'dart:ui' as ui;


// Enum for marker type
enum MarkerType { post, service }

// Model for map items
class MapItem {
  final LatLng location;
  final MarkerType type;
  final String imageUrl; // user/profile image

  MapItem({
    required this.location,
    required this.type,
    required this.imageUrl,
  });
}



class MapScreen extends StatelessWidget {
  final List<MapItem> items;
  final VoidCallback onMarkerTab;
  const MapScreen({super.key, required this.items, required this.onMarkerTab,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🗺 Full screen map
          FlutterMap(
            options:  MapOptions(
              initialCenter: LatLng(50.0, 10.0), // Cairo
              initialZoom: 5,
            ),
            children: [
              /// Tiles (safe & free)
              TileLayer(
                urlTemplate:
                'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                subdomains: ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.traveller.mobileapp',
              ),

              /// Custom markers
              GestureDetector(
                onTap: onMarkerTab,
                child: MarkerLayer(
                  markers: items.map((item) {
                    return Marker(
                      point: item.location,
                      width: 40.w,
                      height: 48.h,
                      child: MapPin(
                        item: item,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          Positioned(
            top: 12.h,
            left: 16.w,
            right: 16.w,
            child: MapSearchBar(),
          ),
        ],
      ),
    );
  }
}






