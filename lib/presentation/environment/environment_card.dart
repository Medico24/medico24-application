import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/environment_model.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/repositories/environment_repository.dart';
import 'package:medico24/core/service_locator.dart';
import 'package:medico24/core/theme/app_colors.dart';

class EnvironmentCard extends StatefulWidget {
  const EnvironmentCard({
    super.key,
    this.environmentRepository,
    this.database,
    this.backgroundImage,
  });

  final EnvironmentRepository? environmentRepository;
  final AppDatabase? database;
  final ImageProvider? backgroundImage;

  @override
  State<EnvironmentCard> createState() => _EnvironmentCardState();
}

class _EnvironmentCardState extends State<EnvironmentCard> {
  final Logger _logger = Logger();
  late final EnvironmentRepository _environmentRepository;
  late final AppDatabase _database;

  EnvironmentConditionsModel? _environmentData;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _environmentRepository =
        widget.environmentRepository ?? serviceLocator.environmentRepository;
    _database = widget.database ?? AppDatabase();
    _loadEnvironmentData();
  }

  late CurrentLocationData? currentLocation;

  Future<void> _loadEnvironmentData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Get current location from database
      currentLocation = await _database.getCurrentLocation();

      if (currentLocation == null ||
          currentLocation?.latitude == null ||
          currentLocation?.longitude == null) {
        setState(() {
          _error = 'Location not available';
          _isLoading = false;
        });
        return;
      }

      _logger.d(
        'Fetching environment data for lat: ${currentLocation?.latitude}, lng: ${currentLocation?.longitude}',
      );

      final data = await _environmentRepository.getEnvironmentConditions(
        latitude: currentLocation?.latitude ?? 22.00,
        longitude: currentLocation?.longitude ?? 88.00,
      );

      if (mounted) {
        setState(() {
          _environmentData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      _logger.e('Error loading environment data: $e');
      if (mounted) {
        setState(() {
          _error = 'Failed to load environment data';
          _isLoading = false;
        });
      }
    }
  }

  String _getAqiDescription(int aqi) {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
    if (aqi <= 200) return 'Unhealthy';
    if (aqi <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.coal,
        borderRadius: BorderRadius.circular(20),
        image: widget.backgroundImage != null
            ? DecorationImage(
                image: widget.backgroundImage!,
                fit: BoxFit.cover,
                opacity: 0.4,
              )
            : null, // No background image for testing
      ),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            )
          : _error != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.air, color: AppColors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _error.toString(),
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  currentLocation?.toString() ?? 'Location unavailable',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(
                      Icons.thermostat,
                      color: AppColors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Weather',
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Weather data unavailable',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Air Quality Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.air, color: AppColors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Air Quality',
                          style: textTheme.bodyLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'AQI: ${_environmentData!.aqi}',
                      style: textTheme.headlineMedium?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getAqiDescription(_environmentData!.aqi),
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),

                // Weather Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.thermostat,
                          color: AppColors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Weather',
                          style: textTheme.bodyLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_environmentData!.temperature}°C',
                      style: textTheme.headlineMedium?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _environmentData!.condition,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
