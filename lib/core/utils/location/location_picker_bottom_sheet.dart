import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerBottomSheet extends StatefulWidget {
  final Position initialPosition;
  final void Function(String locationUrl) onSend;

  const LocationPickerBottomSheet({
    super.key,
    required this.initialPosition,
    required this.onSend,
  });

  @override
  State<LocationPickerBottomSheet> createState() =>
      _LocationPickerBottomSheetState();
}

class _LocationPickerBottomSheetState
    extends State<LocationPickerBottomSheet> {
  MapLibreMapController? controller;
  LatLng? selectedLatLng;

  @override
  void initState() {
    super.initState();
    selectedLatLng = LatLng(
      widget.initialPosition.latitude,
      widget.initialPosition.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: [
          // MAP
          Expanded(
            child: SafeArea(
              child: MapLibreMap(
                styleString:
                'https://tiles.stadiamaps.com/styles/alidade_smooth.json',
                initialCameraPosition: CameraPosition(
                  target: selectedLatLng!,
                  zoom: 15,
                ),
                onMapCreated: (mapController) async {
                  controller = mapController;

                  // Add marker at initial position
                  await controller!.addSymbol(
                    SymbolOptions(
                      geometry: selectedLatLng!,
                      iconImage: "marker-15", // Default MapLibre icon
                      iconSize: 1.5,
                    ),
                  );
                },
                onMapClick: (point, latLng) async {
                  setState(() {
                    selectedLatLng = latLng;
                  });

                  // Move marker to tapped location
                  if (controller != null) {
                    controller!.clearSymbols();
                    await controller!.addSymbol(
                      SymbolOptions(
                        geometry: selectedLatLng!,
                        iconImage: "marker-15",
                        iconSize: 1.5,
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          // SEND BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final locationUrl =
                      'https://www.openstreetmap.org/?mlat=${selectedLatLng!.latitude}&mlon=${selectedLatLng!.longitude}';
                  widget.onSend(locationUrl);
                  Navigator.pop(context);
                },
                child: const Text('Send location'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
