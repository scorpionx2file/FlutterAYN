import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../location/location_picker_bottom_sheet.dart';

Future<Position?> requestLocationPermission() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return null;
  }

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // User permanently denied
    return null;
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

Future<String> getAddressFromCoordinates(double lat, double lng) async {
  final placemarks = await placemarkFromCoordinates(lat, lng);
  if (placemarks.isNotEmpty) {
    final p = placemarks.first;
    return '${p.street}, ${p.locality}';
  }
  return 'Selected Location';
}


void openLocationPicker(BuildContext context,Function(String)SelectedLocation) async {
  final position = await requestLocationPermission();

  if (position == null) {
    // You can show a snackbar or dialog here
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Location permission denied")));
    return;
  }

  final initialLatLng = LatLng(position.latitude, position.longitude);

  if (!context.mounted) return;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return LocationPickerBottomSheet(
        initialPosition: initialLatLng,
        onSend: (locationUrl) async {
          // Extract lat & lon from the OSM URL
          final uri = Uri.parse(locationUrl as String);
          final lat = double.tryParse(uri.queryParameters['mlat'] ?? '');
          final lon = double.tryParse(uri.queryParameters['mlon'] ?? '');
          print("lat: $lat, lon: $lon");


          if (lat != null && lon != null) {
            // Get human-readable address
            final address = await getAddressFromCoordinates(lat, lon);
            print("Address: $address");
            SelectedLocation(address);
          } else {
            SelectedLocation("Unknown Location");
          }
        },
      );
    },
  );
}
