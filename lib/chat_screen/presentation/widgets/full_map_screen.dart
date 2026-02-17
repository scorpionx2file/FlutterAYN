import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../core/theme/fonts/app_text_styles.dart';

class FullMapScreen extends StatelessWidget {
  final LatLng location;

  const FullMapScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.location,
          style: AppTextStyles.titles.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(initialCenter: location, initialZoom: 15),
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
