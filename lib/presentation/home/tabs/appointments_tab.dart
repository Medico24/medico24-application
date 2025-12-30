import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medico24/core/api/models/appointment_model.dart';
import 'package:medico24/core/service_locator.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:medico24/presentation/appointments/appointments_calendar.dart';

class AppointmentsTab extends StatefulWidget {
  final ScrollController scrollController;

  const AppointmentsTab({super.key, required this.scrollController});

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  List<AppointmentModel> _appointments = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final appointments = await serviceLocator.appointmentRepository
          .fetchAndCacheAppointments(pageSize: 100);

      if (mounted) {
        setState(() {
          _appointments = appointments;
          _isLoading = false;
        });
      }
    } catch (e) {
      try {
        final cached = await serviceLocator.appointmentRepository
            .getCachedAppointments();

        if (mounted) {
          setState(() {
            _appointments = cached;
            _error = 'Showing cached data';
            _isLoading = false;
          });
        }
      } catch (cacheError) {
        if (mounted) {
          setState(() {
            _error = 'Failed to load appointments';
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadAppointments,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppointmentsCalendar(appointments: _appointments),
              const SizedBox(height: 24),

              // Error message if any
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.yellow.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _error!,
                      style: TextStyle(color: AppColors.coal),
                    ),
                  ),
                ),
              if (_error != null) const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Upcoming Appointments',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.coal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Loading indicator
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              // Appointments list
              else if (_appointments.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'No appointments found',
                      style: TextStyle(color: AppColors.grey),
                    ),
                  ),
                )
              else
                ..._appointments.map(
                  (appointment) => _buildAppointmentCard(appointment),
                ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(AppointmentModel appointment) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.medical_services, color: AppColors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.doctorName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.coal,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  appointment.reason,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(appointment.appointmentAt),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(appointment.appointmentAt),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Container(
            height: 40,
            width: 1,
            color: AppColors.grey.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () async {
              final phoneNumber = appointment.contactPhone;
              final uri = Uri.parse('tel:$phoneNumber');
              final messenger = ScaffoldMessenger.of(context);
              try {
                await launchUrl(uri);
              } catch (e) {
                if (mounted) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: const Text('Could not launch phone dialer'),
                      backgroundColor: AppColors.red,
                    ),
                  );
                }
              }
            },
            icon: Icon(Icons.phone, color: AppColors.blue, size: 24),
            tooltip: 'Call Doctor',
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final appointmentDay = DateTime(date.year, date.month, date.day);

    if (appointmentDay == today) {
      return 'Today';
    } else if (appointmentDay == tomorrow) {
      return 'Tomorrow';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
