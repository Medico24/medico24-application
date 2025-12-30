import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/pharmacy_model.dart';
import 'package:medico24/core/api/services/pharmacy_api_service.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/repositories/pharmacy_repository.dart';
import 'package:medico24/core/services/location_service.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:medico24/presentation/pharmacy/pharmacy_detail_screen.dart';
import 'package:medico24/presentation/pharmacy/pharmacy_list_screen.dart';

class PharmacyTabContent extends StatefulWidget {
  final ScrollController scrollController;

  const PharmacyTabContent({super.key, required this.scrollController});

  @override
  State<PharmacyTabContent> createState() => _PharmacyTabContentState();
}

class _PharmacyTabContentState extends State<PharmacyTabContent> {
  final Logger _logger = Logger();
  final PharmacyRepository _pharmacyRepository = PharmacyRepository(
    PharmacyApiService(),
  );
  final AppDatabase _database = AppDatabase();

  List<PharmacyModel> _nearbyPharmacies = [];
  bool _isLoading = true;
  String? _errorMessage;
  CurrentLocationData? _currentLocation;
  double? _userLatitude;
  double? _userLongitude;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Try to get current location from device
      try {
        final position = await LocationService.getCurrentLocation();
        _userLatitude = position.latitude;
        _userLongitude = position.longitude;
        _logger.d(
          'Fetched current location: lat=$_userLatitude, lng=$_userLongitude',
        );

        // Save to database for future use
        await _database.updateCurrentLocation(
          title: 'Current Location',
          address: 'Current Location',
          city: '',
          latitude: _userLatitude!,
          longitude: _userLongitude!,
        );
      } catch (e) {
        _logger.w('Failed to get current location: $e');
        // Fallback to database location
        final location = await _database.getCurrentLocation();
        _userLatitude = location?.latitude;
        _userLongitude = location?.longitude;
        _logger.d(
          'Using saved location from database: lat=$_userLatitude, lng=$_userLongitude',
        );
      }

      // Load pharmacies (nearby if location is available, otherwise general list)
      final pharmacies = await _pharmacyRepository.getPharmacies(
        limit: 5,
        latitude: _userLatitude,
        longitude: _userLongitude,
        radiusKm: 10,
        isActive: true,
      );

      setState(() {
        _nearbyPharmacies = pharmacies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load pharmacies';
        _isLoading = false;
      });
    }
  }

  void _navigateToPharmacyList() {
    _logger.d('Navigating to pharmacy list - View All (no location filter)');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PharmacyListScreen(pharmacyRepository: _pharmacyRepository),
      ),
    );
  }

  void _navigateToNearbyPharmacies() {
    _logger.d(
      'Navigating to nearby pharmacies with location: lat=$_userLatitude, lng=$_userLongitude',
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PharmacyListScreen(
          pharmacyRepository: _pharmacyRepository,
          userLatitude: _userLatitude,
          userLongitude: _userLongitude,
          initialNearbySearch: true,
        ),
      ),
    );
  }

  void _navigateToPharmacyDetail(String pharmacyId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PharmacyDetailScreen(
          pharmacyId: pharmacyId,
          pharmacyRepository: _pharmacyRepository,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadData,
      color: AppColors.red,
      child: ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          _buildQuickActions(),
          const SizedBox(height: 24),
          _buildNearbySection(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.near_me,
            title: 'Nearby',
            subtitle: 'Within <5 km',
            color: AppColors.red,
            onTap: _navigateToNearbyPharmacies,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionCard(
            icon: Icons.delivery_dining,
            title: 'Delivery',
            subtitle: 'Home delivery',
            color: AppColors.teal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PharmacyListScreen(
                    pharmacyRepository: _pharmacyRepository,
                    userLatitude: _userLatitude,
                    userLongitude: _userLongitude,
                    initialDeliveryFilter: true,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: _navigateToPharmacyList,
              child: Text(
                'View All',
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(color: AppColors.red),
            ),
          )
        else if (_errorMessage != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 48, color: AppColors.grey),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        else if (_nearbyPharmacies.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(
                    Icons.local_pharmacy_outlined,
                    size: 48,
                    color: AppColors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No pharmacies found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try adjusting your location',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _nearbyPharmacies.length,
            itemBuilder: (context, index) {
              final pharmacy = _nearbyPharmacies[index];
              return _buildPharmacyCard(pharmacy);
            },
          ),
      ],
    );
  }

  Widget _buildPharmacyCard(PharmacyModel pharmacy) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _navigateToPharmacyDetail(pharmacy.id),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      pharmacy.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (pharmacy.isVerified)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.verified, size: 14, color: AppColors.blue),
                          const SizedBox(width: 4),
                          Text(
                            'Verified',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (pharmacy.location != null)
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        pharmacy.fullAddress,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              if (pharmacy.distanceKm != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.directions_walk,
                      size: 16,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${pharmacy.distanceKm!.toStringAsFixed(1)} km away',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  if (pharmacy.rating > 0) ...[
                    Icon(Icons.star, size: 16, color: AppColors.yellow),
                    const SizedBox(width: 4),
                    Text(
                      pharmacy.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 16),
                  ],
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: pharmacy.isOpen
                          ? AppColors.teal.withValues(alpha: 0.1)
                          : AppColors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      pharmacy.isOpen ? 'Open' : 'Closed',
                      style: TextStyle(
                        fontSize: 12,
                        color: pharmacy.isOpen
                            ? AppColors.teal
                            : AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.delivery_dining,
                    size: 20,
                    color: pharmacy.supportsDelivery
                        ? AppColors.red
                        : AppColors.grey,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.store,
                    size: 20,
                    color: pharmacy.supportsPickup
                        ? AppColors.red
                        : AppColors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
