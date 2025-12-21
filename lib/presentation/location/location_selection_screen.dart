import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button and title
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: [
                    Icon(
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

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: AppColors.coal),
                  decoration: InputDecoration(
                    hintText: 'Search for area, street name...',
                    hintStyle: TextStyle(color: AppColors.grey),
                    prefixIcon: Icon(Icons.search, color: AppColors.red),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Use current location
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey.withOpacity(0.2)),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
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
                  'Kora, Madhyamgram, Kolkata',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.coal),
                ),
                trailing: Icon(Icons.chevron_right, color: AppColors.grey),
              ),
            ),

            // Add Address
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey.withOpacity(0.2)),
              ),
              child: ListTile(
                leading: Icon(
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
                trailing: Icon(Icons.chevron_right, color: AppColors.grey),
              ),
            ),

            // Import from Blinkit
            Container(
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
                  child: Center(
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
                trailing: Icon(Icons.chevron_right, color: AppColors.grey),
              ),
            ),

            const SizedBox(height: 16),

            // Saved Addresses Section
            Padding(
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

            const SizedBox(height: 12),

            // Saved Addresses List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildSavedAddressItem(
                    context,
                    icon: Icons.home_outlined,
                    label: 'Home',
                    distance: '866 km',
                    address:
                        'H4 Hostel (Vivekananda), IIITDM Jabalpur, IIITDM Jabalpur, Airport Rd, Pdpm Iiitdm Jab...',
                    phone: '+91-6290597853',
                  ),
                  const SizedBox(height: 12),
                  _buildSavedAddressItem(
                    context,
                    icon: Icons.location_on_outlined,
                    label: 'Bus Stand',
                    distance: '873 km',
                    address: 'In Front Of Daluram, Market, Jabalpur',
                    phone: '+91-6290597853',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Recent Locations Section
            Padding(
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

            const SizedBox(height: 12),

            // Recent Locations List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildRecentLocationItem(
                    context,
                    location: 'Kora',
                    time: '11 m',
                    address: 'Madhyamgram, Kolkata',
                  ),
                  const SizedBox(height: 12),
                  _buildRecentLocationItem(
                    context,
                    location: 'Esplanade',
                    time: '19 d',
                    address: 'Madhya Kolkata',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
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
    required String phone,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(icon, color: AppColors.coal, size: 28),
              const SizedBox(height: 4),
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
                const SizedBox(height: 8),
                Text(
                  'Phone number: $phone',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildIconButton(Icons.more_horiz, AppColors.grey),
                    const SizedBox(width: 16),
                    _buildIconButton(Icons.share_outlined, AppColors.red),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
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
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Icon(Icons.access_time, color: AppColors.grey, size: 24),
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
    );
  }
}
