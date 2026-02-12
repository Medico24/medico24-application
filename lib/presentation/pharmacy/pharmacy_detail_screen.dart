import 'package:flutter/material.dart';
import 'package:medico24/core/api/models/pharmacy_model.dart';
import 'package:medico24/core/repositories/pharmacy_repository.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacyDetailScreen extends StatefulWidget {
  const PharmacyDetailScreen({
    required this.pharmacyId,
    required this.pharmacyRepository,
    super.key,
  });
  final String pharmacyId;
  final PharmacyRepository pharmacyRepository;

  @override
  State<PharmacyDetailScreen> createState() => _PharmacyDetailScreenState();
}

class _PharmacyDetailScreenState extends State<PharmacyDetailScreen> {
  PharmacyModel? _pharmacy;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPharmacyDetails();
  }

  Future<void> _loadPharmacyDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final pharmacy = await widget.pharmacyRepository.getPharmacyById(
        widget.pharmacyId,
      );
      setState(() {
        _pharmacy = pharmacy;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load pharmacy details: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch phone dialer')),
        );
      }
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri.parse('mailto:$email');
    try {
      final canLaunch = await canLaunchUrl(emailUri);
      if (canLaunch) {
        await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch email client')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email client')),
        );
      }
    }
  }

  Future<void> _openMaps() async {
    if (_pharmacy?.location == null) return;

    final lat = _pharmacy!.location!.latitude;
    final lng = _pharmacy!.location!.longitude;
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open maps')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text('Pharmacy Details')),
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.grey),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPharmacyDetails,
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

    if (_pharmacy == null) {
      return const Center(child: Text('Pharmacy not found'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildContactSection(),
          _buildLocationSection(),
          _buildOperatingHours(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.red.withValues(alpha: 0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _pharmacy!.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_pharmacy!.isVerified)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.verified, size: 16, color: AppColors.white),
                      SizedBox(width: 4),
                      Text(
                        'Verified',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (_pharmacy!.description != null) ...[
            const SizedBox(height: 12),
            Text(
              _pharmacy!.description!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
            ),
          ],
          const SizedBox(height: 8),
          Column(
            children: [
              if (_pharmacy!.rating > 0)
                Row(
                  children: [
                    const Icon(Icons.star, size: 20, color: AppColors.yellow),
                    const SizedBox(width: 4),
                    Text(
                      _pharmacy!.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${_pharmacy!.ratingCount} reviews)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildFeatureChip(
                    icon: Icons.access_time,
                    label: _pharmacy!.isOpen ? 'Open Now' : 'Closed',
                    color: _pharmacy!.isOpen ? AppColors.green : AppColors.grey,
                  ),
                  const SizedBox(width: 4),
                  if (_pharmacy!.supportsDelivery)
                    _buildFeatureChip(
                      icon: Icons.delivery_dining,
                      label: 'Home Delivery',
                      color: AppColors.teal,
                    ),
                  const SizedBox(width: 4),
                  if (_pharmacy!.supportsPickup)
                    _buildFeatureChip(
                      icon: Icons.store,
                      label: 'In-Store Pickup',
                      color: AppColors.blue,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    if (_pharmacy!.phone == null && _pharmacy!.email == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (_pharmacy!.phone != null)
            _buildContactItem(
              icon: Icons.phone,
              title: 'Phone',
              value: _pharmacy!.phone!,
              onTap: () => _makePhoneCall(_pharmacy!.phone!),
            ),
          if (_pharmacy!.email != null)
            _buildContactItem(
              icon: Icons.email,
              title: 'Email',
              value: _pharmacy!.email!,
              onTap: () => _sendEmail(_pharmacy!.email!),
            ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.red, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodySmall),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    if (_pharmacy!.location == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _openMaps,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.red.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _pharmacy!.fullAddress,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tap to open in maps',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: AppColors.red),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.red,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          if (_pharmacy!.distanceKm != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.directions_walk,
                  size: 16,
                  color: AppColors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_pharmacy!.distanceKm!.toStringAsFixed(1)} km away from you',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOperatingHours() {
    if (_pharmacy!.hours == null || _pharmacy!.hours!.isEmpty) {
      return const SizedBox.shrink();
    }

    final openingMessage = _getOpeningMessage();
    final currentDay = DateTime.now().weekday;
    final nextOpeningDay = _getNextOpeningDay();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Opening Time',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (openingMessage != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _pharmacy!.isOpen
                        ? AppColors.teal.withValues(alpha: 0.1)
                        : AppColors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    openingMessage,
                    style: TextStyle(
                      fontSize: 12,
                      color: _pharmacy!.isOpen ? AppColors.teal : AppColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: _pharmacy!.hours!.map((hours) {
                final isToday = hours.dayOfWeek == currentDay;
                final isNextOpeningDay = hours.dayOfWeek == nextOpeningDay;
                final shouldHighlight = isToday || isNextOpeningDay;

                Color bgColor = Colors.transparent;
                if (isToday && _pharmacy!.isOpen) {
                  bgColor = AppColors.teal.withValues(alpha: 0.05);
                } else if (isToday && !_pharmacy!.isOpen) {
                  bgColor = AppColors.grey.withValues(alpha: 0.05);
                } else if (isNextOpeningDay) {
                  bgColor = AppColors.red.withValues(alpha: 0.05);
                }

                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          hours.dayName,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: shouldHighlight
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: shouldHighlight
                                    ? AppColors.coal
                                    : AppColors.coal,
                              ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          hours.isClosed
                              ? 'Closed'
                              : '${_formatTime(hours.openTime)} - ${_formatTime(hours.closeTime)}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: shouldHighlight
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: hours.isClosed
                                    ? AppColors.grey
                                    : AppColors.coal,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  String? _getOpeningMessage() {
    if (_pharmacy!.hours == null || _pharmacy!.hours!.isEmpty) return null;

    final now = DateTime.now();
    final currentDay = now.weekday;
    final currentTime = TimeOfDay.now();

    // Check if open today
    final todayHours = _pharmacy!.hours!.firstWhere(
      (h) => h.dayOfWeek == currentDay,
      orElse: () => PharmacyHoursModel(
        id: '',
        pharmacyId: '',
        dayOfWeek: currentDay,
        openTime: '00:00:00',
        closeTime: '00:00:00',
        isClosed: true,
      ),
    );

    if (!todayHours.isClosed) {
      final openParts = todayHours.openTime.split(':');
      final closeParts = todayHours.closeTime.split(':');
      final openTime = TimeOfDay(
        hour: int.parse(openParts[0]),
        minute: int.parse(openParts[1]),
      );
      final closeTime = TimeOfDay(
        hour: int.parse(closeParts[0]),
        minute: int.parse(closeParts[1]),
      );

      final currentMinutes = currentTime.hour * 60 + currentTime.minute;
      final openMinutes = openTime.hour * 60 + openTime.minute;
      final closeMinutes = closeTime.hour * 60 + closeTime.minute;

      if (currentMinutes >= openMinutes && currentMinutes < closeMinutes) {
        // Currently open - show closing time
        final minutesUntilClose = closeMinutes - currentMinutes;
        final hours = minutesUntilClose ~/ 60;
        final minutes = minutesUntilClose % 60;
        if (hours > 0) {
          return 'Closes in $hours hour${hours > 1 ? 's' : ''} ${minutes > 0 ? '$minutes min' : ''}';
        } else {
          return 'Closes in $minutes minute${minutes > 1 ? 's' : ''}';
        }
      } else if (currentMinutes < openMinutes) {
        // Opens later today
        final minutesUntilOpen = openMinutes - currentMinutes;
        final hours = minutesUntilOpen ~/ 60;
        final minutes = minutesUntilOpen % 60;
        if (hours > 0) {
          return 'Opens in $hours hour${hours > 1 ? 's' : ''} ${minutes > 0 ? '$minutes min' : ''}';
        } else {
          return 'Opens in $minutes minute${minutes > 1 ? 's' : ''}';
        }
      }
    }

    // Find next opening day
    for (int i = 1; i <= 7; i++) {
      final nextDay = ((currentDay - 1 + i) % 7) + 1;
      final nextDayHours = _pharmacy!.hours!.firstWhere(
        (h) => h.dayOfWeek == nextDay,
        orElse: () => PharmacyHoursModel(
          id: '',
          pharmacyId: '',
          dayOfWeek: nextDay,
          openTime: '00:00:00',
          closeTime: '00:00:00',
          isClosed: true,
        ),
      );

      if (!nextDayHours.isClosed) {
        if (i == 1) {
          return 'Opens tomorrow at ${_formatTime(nextDayHours.openTime)}';
        } else {
          return 'Opens on ${nextDayHours.dayName} at ${_formatTime(nextDayHours.openTime)}';
        }
      }
    }

    return null;
  }

  int? _getNextOpeningDay() {
    if (_pharmacy!.hours == null || _pharmacy!.hours!.isEmpty) return null;

    final now = DateTime.now();
    final currentDay = now.weekday;
    final currentTime = TimeOfDay.now();

    // Check if open today
    final todayHours = _pharmacy!.hours!.firstWhere(
      (h) => h.dayOfWeek == currentDay,
      orElse: () => PharmacyHoursModel(
        id: '',
        pharmacyId: '',
        dayOfWeek: currentDay,
        openTime: '00:00:00',
        closeTime: '00:00:00',
        isClosed: true,
      ),
    );

    if (!todayHours.isClosed) {
      final openParts = todayHours.openTime.split(':');
      final openTime = TimeOfDay(
        hour: int.parse(openParts[0]),
        minute: int.parse(openParts[1]),
      );

      final currentMinutes = currentTime.hour * 60 + currentTime.minute;
      final openMinutes = openTime.hour * 60 + openTime.minute;

      if (currentMinutes < openMinutes) {
        return null; // Opens later today, no need to highlight next day
      }
    }

    // Find next opening day
    for (int i = 1; i <= 7; i++) {
      final nextDay = ((currentDay - 1 + i) % 7) + 1;
      final nextDayHours = _pharmacy!.hours!.firstWhere(
        (h) => h.dayOfWeek == nextDay,
        orElse: () => PharmacyHoursModel(
          id: '',
          pharmacyId: '',
          dayOfWeek: nextDay,
          openTime: '00:00:00',
          closeTime: '00:00:00',
          isClosed: true,
        ),
      );

      if (!nextDayHours.isClosed) {
        return nextDay;
      }
    }

    return null;
  }

  Widget _buildFeatureChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
