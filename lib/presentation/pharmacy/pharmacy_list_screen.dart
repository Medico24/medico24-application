import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/pharmacy_model.dart';
import 'package:medico24/core/repositories/pharmacy_repository.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:medico24/presentation/pharmacy/pharmacy_detail_screen.dart';

class PharmacyListScreen extends StatefulWidget {
  const PharmacyListScreen({
    required this.pharmacyRepository,
    super.key,
    this.userLatitude,
    this.userLongitude,
    this.initialDeliveryFilter = false,
    this.initialPickupFilter = false,
    this.initialVerifiedFilter = false,
    this.initialNearbySearch = false,
  });
  final PharmacyRepository pharmacyRepository;
  final double? userLatitude;
  final double? userLongitude;
  final bool initialDeliveryFilter;
  final bool initialPickupFilter;
  final bool initialVerifiedFilter;
  final bool initialNearbySearch;

  @override
  State<PharmacyListScreen> createState() => _PharmacyListScreenState();
}

class _PharmacyListScreenState extends State<PharmacyListScreen> {
  final Logger _logger = Logger();
  final TextEditingController _searchController = TextEditingController();
  List<PharmacyModel> _pharmacies = [];
  List<PharmacyModel> _filteredPharmacies = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _errorMessage;
  final ScrollController _scrollController = ScrollController();

  // Filter states
  late bool _showVerifiedOnly;
  late bool _showDeliveryOnly;
  late bool _showPickupOnly;
  late bool _useNearbySearch;
  double _radiusKm = 5.0;

  int _skip = 0;
  final int _limit = 100;

  @override
  void initState() {
    super.initState();
    // Initialize filters from widget parameters
    _showVerifiedOnly = widget.initialVerifiedFilter;
    _showDeliveryOnly = widget.initialDeliveryFilter;
    _showPickupOnly = widget.initialPickupFilter;
    _useNearbySearch = widget.initialNearbySearch;

    // Debug log location data
    _logger.d('PharmacyListScreen initialized with:');
    _logger.d('  userLatitude: ${widget.userLatitude}');
    _logger.d('  userLongitude: ${widget.userLongitude}');
    _logger.d('  initialNearbySearch: ${widget.initialNearbySearch}');

    _loadPharmacies();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _pharmacies.length >= _limit) {
        _loadMorePharmacies();
      }
    }
  }

  Future<void> _loadPharmacies() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _skip = 0;
    });

    try {
      // Use getPharmacies with optional lat/long
      final pharmacies = await widget.pharmacyRepository.getPharmacies(
        skip: _skip,
        limit: _limit,
        latitude: widget.userLatitude,
        longitude: widget.userLongitude,
        radiusKm: _radiusKm,
        isActive: true,
        isVerified: _showVerifiedOnly ? true : null,
        supportsDelivery: _showDeliveryOnly ? true : null,
        supportsPickup: _showPickupOnly ? true : null,
      );

      setState(() {
        _pharmacies = pharmacies;
        _filteredPharmacies = pharmacies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load pharmacies: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMorePharmacies() async {
    setState(() {
      _isLoadingMore = true;
    });

    try {
      _skip += _limit;

      // Use getPharmacies with lat/long for nearby search
      final morePharmacies = await widget.pharmacyRepository.getPharmacies(
        skip: _skip,
        limit: _limit,
        latitude: widget.userLatitude,
        longitude: widget.userLongitude,
        radiusKm: _radiusKm,
        isActive: true,
        isVerified: _showVerifiedOnly ? true : null,
        supportsDelivery: _showDeliveryOnly ? true : null,
        supportsPickup: _showPickupOnly ? true : null,
      );

      setState(() {
        _pharmacies.addAll(morePharmacies);
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _filterPharmacies(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPharmacies = _pharmacies;
      } else {
        _filteredPharmacies = _pharmacies.where((pharmacy) {
          final nameLower = pharmacy.name.toLowerCase();
          final addressLower = pharmacy.fullAddress.toLowerCase();
          final searchLower = query.toLowerCase();
          return nameLower.contains(searchLower) ||
              addressLower.contains(searchLower);
        }).toList();
      }
    });
  }

  void _showFiltersBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFiltersSheet(),
    );
  }

  Widget _buildFiltersSheet() {
    bool tempVerified = _showVerifiedOnly;
    bool tempDelivery = _showDeliveryOnly;
    bool tempPickup = _showPickupOnly;
    bool tempNearby = _useNearbySearch;
    double tempRadius = _radiusKm;

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Pharmacies',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Verified Only'),
                value: tempVerified,
                activeThumbColor: AppColors.red,
                onChanged: (value) {
                  setModalState(() {
                    tempVerified = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Supports Delivery'),
                value: tempDelivery,
                activeThumbColor: AppColors.red,
                onChanged: (value) {
                  setModalState(() {
                    tempDelivery = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Supports Pickup'),
                value: tempPickup,
                activeThumbColor: AppColors.red,
                onChanged: (value) {
                  setModalState(() {
                    tempPickup = value;
                  });
                },
              ),
              if (widget.userLatitude != null && widget.userLongitude != null)
                Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Search Nearby'),
                      value: tempNearby,
                      activeThumbColor: AppColors.red,
                      onChanged: (value) {
                        setModalState(() {
                          tempNearby = value;
                        });
                      },
                    ),
                    if (tempNearby)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Radius: ${tempRadius.toStringAsFixed(0)} km',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Slider(
                              value: tempRadius,
                              min: 1,
                              max: 50,
                              divisions: 49,
                              activeColor: AppColors.red,
                              onChanged: (value) {
                                setModalState(() {
                                  tempRadius = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showVerifiedOnly = tempVerified;
                      _showDeliveryOnly = tempDelivery;
                      _showPickupOnly = tempPickup;
                      _useNearbySearch = tempNearby;
                      _radiusKm = tempRadius;
                    });
                    Navigator.pop(context);
                    _loadPharmacies();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Pharmacies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFiltersBottomSheet,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.red),
      );
    }

    if (_errorMessage != null) {
      final isLocationError = _errorMessage!.contains('Location is required');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isLocationError ? Icons.location_off : Icons.error_outline,
              size: 64,
              color: AppColors.grey,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _errorMessage!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            if (isLocationError)
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                icon: const Icon(Icons.settings, color: AppColors.white),
                label: const Text(
                  'Go Back',
                  style: TextStyle(color: AppColors.white),
                ),
              )
            else
              ElevatedButton(
                onPressed: _loadPharmacies,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                child: const Text(
                  'Retry',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
          ],
        ),
      );
    }

    if (_pharmacies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_pharmacy_outlined,
              size: 64,
              color: AppColors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No pharmacies found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: _filterPharmacies,
            decoration: InputDecoration(
              hintText: 'Search pharmacies...',
              prefixIcon: const Icon(Icons.search, color: AppColors.grey),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppColors.grey),
                      onPressed: () {
                        _searchController.clear();
                        _filterPharmacies('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.grey.withValues(alpha: 0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.grey.withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.red),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
          ),
        ),
        // Pharmacy list
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadPharmacies,
            color: AppColors.red,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredPharmacies.length + (_isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _filteredPharmacies.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.red),
                    ),
                  );
                }

                final pharmacy = _filteredPharmacies[index];
                return _buildPharmacyCard(pharmacy);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPharmacyCard(PharmacyModel pharmacy) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PharmacyDetailScreen(
                pharmacyId: pharmacy.id,
                pharmacyRepository: widget.pharmacyRepository,
              ),
            ),
          );
        },
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
                      child: const Row(
                        children: [
                          Icon(Icons.verified, size: 14, color: AppColors.blue),
                          SizedBox(width: 4),
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
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        pharmacy.fullAddress,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              if (pharmacy.distanceKm != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
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
              const SizedBox(height: 8),
              Row(
                children: [
                  if (pharmacy.rating > 0) ...[
                    const Icon(Icons.star, size: 16, color: AppColors.yellow),
                    const SizedBox(width: 4),
                    Text(
                      '${pharmacy.rating.toStringAsFixed(1)} (${pharmacy.ratingCount})',
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
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (pharmacy.supportsDelivery)
                    _buildFeatureChip(Icons.delivery_dining, 'Delivery'),
                  if (pharmacy.supportsDelivery && pharmacy.supportsPickup)
                    const SizedBox(width: 8),
                  if (pharmacy.supportsPickup)
                    _buildFeatureChip(Icons.store, 'Pickup'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.red),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.red),
          ),
        ],
      ),
    );
  }
}
