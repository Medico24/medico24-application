import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medico24/core/theme/app_colors.dart';

/// Google Map widget with static centered pin
class MapWithCenteredPin extends StatelessWidget {
  const MapWithCenteredPin({
    required this.center,
    required this.isLoading,
    required this.onMapCreated,
    required this.onCameraMove,
    required this.onCameraIdle,
    super.key,
  });
  final LatLng center;
  final bool isLoading;
  final void Function(GoogleMapController) onMapCreated;
  final void Function(CameraPosition) onCameraMove;
  final VoidCallback onCameraIdle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Google Map (full screen)
        GoogleMap(
          initialCameraPosition: CameraPosition(target: center, zoom: 16),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: onMapCreated,
          onCameraMove: onCameraMove,
          onCameraIdle: onCameraIdle,
        ),

        // Static pin in center
        const Center(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 24,
            ), // Offset to align pin point with center
            child: Icon(Icons.location_on, size: 48, color: AppColors.red),
          ),
        ),

        // Move pin message
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.coal.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Move map to adjust pin location',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // Loading indicator overlay
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
