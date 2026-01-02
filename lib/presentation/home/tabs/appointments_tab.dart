import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medico24/core/api/models/appointment_model.dart';
import 'package:medico24/core/service_locator.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:medico24/presentation/appointments/appointments_calendar.dart';

class AppointmentsTab extends StatefulWidget {
  const AppointmentsTab({required this.scrollController, super.key});
  final ScrollController scrollController;

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  List<AppointmentModel> _appointments = [];
  List<AppointmentModel> _upcomingAppointments = [];
  List<AppointmentModel> _pastAppointments = [];
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
        final now = DateTime.now();
        final upcoming = <AppointmentModel>[];
        final past = <AppointmentModel>[];

        for (final appointment in appointments) {
          if (appointment.appointmentAt.isAfter(now)) {
            upcoming.add(appointment);
          } else {
            past.add(appointment);
          }
        }

        // Sort upcoming ascending (earliest first)
        upcoming.sort((a, b) => a.appointmentAt.compareTo(b.appointmentAt));
        // Sort past descending (most recent first)
        past.sort((a, b) => b.appointmentAt.compareTo(a.appointmentAt));

        setState(() {
          _appointments = appointments;
          _upcomingAppointments = upcoming;
          _pastAppointments = past;
          _isLoading = false;
        });
      }
    } catch (e) {
      try {
        final cached = await serviceLocator.appointmentRepository
            .getCachedAppointments();

        if (mounted) {
          final now = DateTime.now();
          final upcoming = <AppointmentModel>[];
          final past = <AppointmentModel>[];

          for (final appointment in cached) {
            if (appointment.appointmentAt.isAfter(now)) {
              upcoming.add(appointment);
            } else {
              past.add(appointment);
            }
          }

          upcoming.sort((a, b) => a.appointmentAt.compareTo(b.appointmentAt));
          past.sort((a, b) => b.appointmentAt.compareTo(a.appointmentAt));

          setState(() {
            _appointments = cached;
            _upcomingAppointments = upcoming;
            _pastAppointments = past;
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
                      style: const TextStyle(color: AppColors.coal),
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
              // Upcoming Appointments list
              else if (_upcomingAppointments.isEmpty &&
                  _pastAppointments.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'No appointments found',
                      style: TextStyle(color: AppColors.grey),
                    ),
                  ),
                )
              else
                ..._upcomingAppointments.map(
                  (appointment) =>
                      _buildAppointmentCard(appointment, isPast: false),
                ),

              if (!_isLoading &&
                  _upcomingAppointments.isEmpty &&
                  _pastAppointments.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'No upcoming appointments',
                      style: TextStyle(color: AppColors.grey),
                    ),
                  ),
                ),

              // Past Appointments Section
              if (_pastAppointments.isNotEmpty) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Past Appointments',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ..._pastAppointments.map(
                  (appointment) =>
                      _buildAppointmentCard(appointment, isPast: true),
                ),
              ],

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(
    AppointmentModel appointment, {
    required bool isPast,
  }) {
    final cardColor = isPast
        ? AppColors.grey.withValues(alpha: 0.05)
        : AppColors.white;
    final iconBgColor = isPast
        ? AppColors.grey.withValues(alpha: 0.1)
        : AppColors.blue.withValues(alpha: 0.1);
    final iconColor = isPast ? AppColors.grey : AppColors.blue;
    final textColor = isPast ? AppColors.grey : AppColors.coal;
    final accentColor = isPast ? AppColors.grey : AppColors.blue;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.medical_services, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.doctorName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: textColor,
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
                  color: accentColor,
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
            onPressed: isPast
                ? null
                : () async {
                    final phoneNumber = appointment.contactPhone;
                    final uri = Uri.parse('tel:$phoneNumber');
                    final messenger = ScaffoldMessenger.of(context);
                    try {
                      await launchUrl(uri);
                    } catch (e) {
                      if (mounted) {
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Could not launch phone dialer'),
                            backgroundColor: AppColors.red,
                          ),
                        );
                      }
                    }
                  },
            icon: Icon(Icons.phone, color: accentColor, size: 24),
            tooltip: isPast ? null : 'Call Doctor',
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
