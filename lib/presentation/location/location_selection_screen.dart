import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medico24/core/router/app_router.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/theme/app_colors.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final AppDatabase _database = AppDatabase();
  List<SavedAddressesData> _savedAddresses = [];
  List<RecentLocation> _recentLocations = [];
  CurrentLocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final saved = await _database.getAllSavedAddresses();
    final recent = await _database.getRecentLocations(limit: 5);
    final current = await _database.getCurrentLocation();

    // Filter out invalid addresses from recent locations
    final validRecent = recent.where((location) {
      return location.address.isNotEmpty &&
          !location.address.contains('Could not fetch') &&
          !location.address.contains('Unable to fetch');
    }).toList();

    if (mounted) {
      setState(() {
        _savedAddresses = saved;
        _recentLocations = validRecent;
        _currentLocation = current;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header with back button and title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 32,
                        color: AppColors.coal,
                      ),

                      const SizedBox(width: 12),
                      Text(
                        'Select a location',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.coal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.grey.withValues(alpha: 0.3),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: AppColors.coal),
                    decoration: const InputDecoration(
                      hintText: 'Search for area, street name...',
                      hintStyle: TextStyle(color: AppColors.grey),
                      prefixIcon: Icon(Icons.search, color: AppColors.red),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Use current location
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.2),
                  ),
                ),
                child: ListTile(
                  onTap: () async {
                    final result = await context.push(AppRouter.addAddress);
                    if (result == true) {
                      _loadData(); // Reload data when returning from add address
                    }
                  },
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.red.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.my_location,
                      color: AppColors.red,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    'Use current location',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    _currentLocation != null
                        ? '${_currentLocation!.title}, ${_currentLocation!.city}'
                        : 'Enable location services',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.coal),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),

            // Add Address
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.2),
                  ),
                ),
                child: ListTile(
                  onTap: () async {
                    final result = await context.push(AppRouter.addAddress);
                    if (result == true) {
                      _loadData(); // Reload data when returning from add address
                    }
                  },
                  leading: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.red,
                    size: 28,
                  ),
                  title: Text(
                    'Add Address',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),

            // Import from Map
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.2),
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Map',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'Import addresses from Map',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Saved Addresses Section Header
            if (_savedAddresses.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'SAVED ADDRESSES',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

            if (_savedAddresses.isNotEmpty)
              const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Saved Addresses List
            if (_savedAddresses.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final address = _savedAddresses[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: index == _savedAddresses.length - 1 ? 0 : 12,
                    ),
                    child: _buildSavedAddressItem(
                      context,
                      icon: address.isDefault
                          ? Icons.home_outlined
                          : Icons.location_on_outlined,
                      label: address.title,
                      distance: '',
                      address: '${address.address}, ${address.city}',
                      onTap: () async {
                        await _database.updateCurrentLocation(
                          title: address.title,
                          address: address.address,
                          city: address.city,
                          latitude: address.latitude,
                          longitude: address.longitude,
                        );
                        await _database.addRecentLocation(
                          address: address.address,
                          city: address.city,
                          latitude: address.latitude,
                          longitude: address.longitude,
                        );
                        if (mounted) {
                          context.pop();
                        }
                      },
                      onDelete: () async {
                        await _database.deleteSavedAddress(address.id);
                        _loadData();
                      },
                    ),
                  );
                }, childCount: _savedAddresses.length),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Recent Locations Section Header
            if (_recentLocations.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'RECENT LOCATIONS',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

            if (_recentLocations.isNotEmpty)
              const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Recent Locations List
            if (_recentLocations.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final location = _recentLocations[index];
                  final now = DateTime.now();
                  final diff = now.difference(location.accessedAt);
                  final timeAgo = diff.inDays > 0
                      ? '${diff.inDays} d'
                      : diff.inHours > 0
                      ? '${diff.inHours} h'
                      : '${diff.inMinutes} m';

                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: index == _recentLocations.length - 1 ? 0 : 12,
                    ),
                    child: _buildRecentLocationItem(
                      context,
                      location: location.city.split(',').first,
                      time: timeAgo,
                      address: location.address,
                      onTap: () async {
                        await _database.updateCurrentLocation(
                          title: location.city.split(',').first,
                          address: location.address,
                          city: location.city,
                          latitude: location.latitude,
                          longitude: location.longitude,
                        );
                        await _database.addRecentLocation(
                          address: location.address,
                          city: location.city,
                          latitude: location.latitude,
                          longitude: location.longitude,
                        );
                        if (mounted) {
                          context.pop();
                        }
                      },
                    ),
                  );
                }, childCount: _recentLocations.length),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedAddressItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String distance,
    required String address,
    VoidCallback? onTap,
    VoidCallback? onDelete,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(icon, color: AppColors.coal, size: 28),
                if (distance.isNotEmpty) const SizedBox(height: 4),
                if (distance.isNotEmpty)
                  Text(
                    distance,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: AppColors.grey),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.coal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.coal),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (onDelete != null) const SizedBox(height: 12),
                  if (onDelete != null)
                    Row(
                      children: [
                        InkWell(
                          onTap: onDelete,
                          child: _buildIconButton(
                            Icons.delete_outline,
                            AppColors.red,
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildIconButton(Icons.share_outlined, AppColors.blue),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildRecentLocationItem(
    BuildContext context, {
    required String location,
    required String time,
    required String address,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Column(
              children: [
                const Icon(Icons.access_time, color: AppColors.grey, size: 24),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppColors.grey),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.coal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
