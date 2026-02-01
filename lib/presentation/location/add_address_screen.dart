import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:medico24/core/services/location_service.dart';
import 'package:medico24/core/services/geocoding_service.dart';
import 'package:medico24/core/services/places_service.dart';
import 'package:medico24/core/services/place_details_service.dart';
import 'package:medico24/core/utils/debouncer.dart';
import 'package:medico24/core/service_locator.dart';
import 'package:medico24/presentation/location/widgets/location_search_bar.dart';
import 'package:medico24/presentation/location/widgets/search_suggestions_overlay.dart';
import 'package:medico24/presentation/location/widgets/map_with_centered_pin.dart';
import 'package:medico24/presentation/location/widgets/address_bottom_sheet.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  // Use singleton database instance
  late final AppDatabase _database = serviceLocator.database;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addressDetailsController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedAddressType = 'Home';
  String _selectedLocation = 'Select location';
  String _selectedCity = '';

  // Map related variables
  GoogleMapController? _mapController;
  LatLng _center = const LatLng(22.5726, 88.3639); // Kolkata fallback
  LatLng? _lastCenter;
  String _address = 'Fetching address...';
  bool _isLoadingAddress = false;
  bool _isLoadingLocation = false;
  final Debouncer _debouncer = Debouncer(800);
  final Debouncer _searchDebouncer = Debouncer(400); // 400ms for search
  List<PlaceSuggestion> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void dispose() {
    _searchController.dispose();
    _addressDetailsController.dispose();
    _phoneController.dispose();
    _mapController?.dispose();
    _debouncer.dispose();
    _searchDebouncer.dispose();
    // Don't close the database - it's a singleton managed by ServiceLocator
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  /// Initialize user's current location
  Future<void> _initLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      final position = await LocationService.getCurrentLocation();
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        _isLoadingLocation = false;
      });
      // Move camera to current location when map is ready
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(_center, 16));
    } catch (e) {
      setState(() => _isLoadingLocation = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not get current location: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  /// Handle camera movement to update center position
  void _onCameraMove(CameraPosition position) {
    _center = position.target;
  }

  /// Handle camera idle to trigger reverse geocoding
  Future<void> _onCameraIdle() async {
    // Only reverse geocode if position changed significantly
    if (_lastCenter != null) {
      final distance = _calculateDistance(
        _lastCenter!.latitude,
        _lastCenter!.longitude,
        _center.latitude,
        _center.longitude,
      );
      // Skip if moved less than 50 meters
      if (distance < 0.05) return;
    }

    _lastCenter = _center;
    _debouncer.run(() => _reverseGeocode());
  }

  /// Calculate distance between two points (simple approximation)
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return ((lat1 - lat2).abs() + (lon1 - lon2).abs());
  }

  /// Reverse geocode current center position
  Future<void> _reverseGeocode() async {
    setState(() => _isLoadingAddress = true);
    try {
      final addressComponents = await GeocodingService.getAddressComponents(
        _center.latitude,
        _center.longitude,
      );

      final formattedAddress = addressComponents['formatted_address'];
      final locality = addressComponents['locality'];
      final city = addressComponents['city'];
      final state = addressComponents['state'];

      if (formattedAddress == null ||
          (formattedAddress is String && formattedAddress.isEmpty)) {
        throw Exception('No address found');
      }

      setState(() {
        _address = formattedAddress as String;
        _selectedLocation =
            locality as String? ?? city as String? ?? 'Select location';
        _selectedCity = city != null && state != null ? '$city, $state' : '';
        _isLoadingAddress = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _address = 'Unable to fetch address';
          _selectedLocation = 'Select location';
          _selectedCity = '';
          _isLoadingAddress = false;
        });

        // Only show error if it's not the initial load
        if (_lastCenter != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not fetch address: ${e.toString()}'),
              backgroundColor: AppColors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  /// Handle search input changes
  void _onSearchChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    _searchDebouncer.run(() async {
      try {
        final suggestions = await PlacesService.autocomplete(value);
        setState(() {
          _suggestions = suggestions;
          _showSuggestions = suggestions.isNotEmpty;
        });
      } catch (e) {
        // Silently handle search errors
      }
    });
  }

  /// Handle place selection from suggestions
  Future<void> _onPlaceSelected(PlaceSuggestion suggestion) async {
    // Cancel any pending search debouncer
    _searchDebouncer.cancel();

    setState(() {
      _showSuggestions = false;
      _suggestions = [];
    });

    _searchController.clear();
    FocusScope.of(context).unfocus();

    try {
      final latLng = await PlaceDetailsService.getLatLng(suggestion.placeId);

      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));

      setState(() => _center = latLng);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not navigate to location: $e'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  /// Handle location selection confirmation
  void _onSelectLocation() {
    // Don't confirm if address fetch failed
    if (_address == 'Unable to fetch address' ||
        _address == 'Fetching address...') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait for address to load or move the pin'),
          backgroundColor: AppColors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _selectedLocation = _address.split(',').first.trim();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location confirmed'),
        backgroundColor: AppColors.blue,
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> _saveAddress() async {
    if (_selectedLocation == 'Select location' ||
        _address == 'Unable to fetch address' ||
        _address == 'Fetching address...' ||
        _addressDetailsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please confirm location and fill all required fields'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    final fullAddress = '$_address, ${_addressDetailsController.text}';

    // Save address with coordinates
    await _database.addSavedAddress(
      title: _selectedAddressType,
      address: fullAddress,
      city: _selectedCity,
      latitude: _center.latitude,
      longitude: _center.longitude,
      isDefault: _selectedAddressType == 'Home',
    );

    // Update current location so weather/air quality work immediately
    await _database.updateCurrentLocation(
      title: _selectedAddressType,
      address: fullAddress,
      city: _selectedCity,
      latitude: _center.latitude,
      longitude: _center.longitude,
    );

    // Add to recent locations
    await _database.addRecentLocation(
      address: fullAddress,
      city: _selectedCity,
      latitude: _center.latitude,
      longitude: _center.longitude,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address saved successfully'),
          backgroundColor: AppColors.blue,
        ),
      );
      context.pop(true); // Return true to indicate address was saved
    }
  }

  Future<void> _requestLocationPermission() async {
    setState(() => _isLoadingLocation = true);
    try {
      final position = await LocationService.getCurrentLocation();
      final latLng = LatLng(position.latitude, position.longitude);

      print('=== GOT CURRENT LOCATION ===');
      print('Position: lat=${position.latitude}, lng=${position.longitude}');

      setState(() {
        _center = latLng;
        _isLoadingLocation = false;
      });

      print(
        'Set _center to: lat=${_center.latitude}, lng=${_center.longitude}',
      );

      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));

      // Trigger reverse geocoding and auto-confirm location
      await _reverseGeocode();

      if (mounted) {
        // Auto-select the location after fetching address
        if (_address != 'Unable to fetch address' &&
            _address != 'Fetching address...') {
          setState(() {
            _selectedLocation = _address.split(',').first.trim();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location accessed successfully'),
              backgroundColor: AppColors.blue,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Could not fetch address for current location. Try moving the pin.',
              ),
              backgroundColor: AppColors.red,
            ),
          );
        }
      }
    } catch (e) {
      setState(() => _isLoadingLocation = false);

      if (mounted) {
        final shouldOpen = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permission'),
            content: Text(
              'Location permission is required to use current location. ${e.toString()}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );

        if (shouldOpen == true) {
          await openAppSettings();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.coal),
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LocationSearchBar(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {}); // Trigger rebuild for suffix icon
                        _onSearchChanged(value);
                      },
                      onClear: () {
                        _searchController.clear();
                        setState(() {
                          _suggestions = [];
                          _showSuggestions = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Map with bottom sheet
            Expanded(
              child: Stack(
                children: [
                  // Map with centered pin
                  MapWithCenteredPin(
                    center: _center,
                    isLoading: _isLoadingAddress || _isLoadingLocation,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    onCameraMove: _onCameraMove,
                    onCameraIdle: _onCameraIdle,
                  ),

                  // Search suggestions overlay
                  if (_showSuggestions && _suggestions.isNotEmpty)
                    SearchSuggestionsOverlay(
                      suggestions: _suggestions,
                      onSuggestionTap: _onPlaceSelected,
                    ),

                  // Bottom draggable sheet
                  DraggableScrollableSheet(
                    initialChildSize: 0.45, // Start at 45% of screen
                    minChildSize: 0.35, // Can collapse to 35%
                    maxChildSize: 0.75, // Can expand to 75% to prevent overflow
                    builder:
                        (
                          BuildContext context,
                          ScrollController scrollController,
                        ) {
                          return AddressBottomSheet(
                            scrollController: scrollController,
                            onUseCurrentLocation: _requestLocationPermission,
                            onSelectLocation: _onSelectLocation,
                            selectedLocation: _selectedLocation,
                            selectedCity: _selectedCity,
                            address: _address,
                            addressDetailsController: _addressDetailsController,
                            phoneController: _phoneController,
                            selectedAddressType: _selectedAddressType,
                            onAddressTypeChanged: (type) {
                              setState(() {
                                _selectedAddressType = type;
                              });
                            },
                            onSaveAddress: _saveAddress,
                          );
                        },
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
