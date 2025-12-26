import 'package:flutter/material.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:medico24/presentation/appointments/appointments_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentsTab extends StatelessWidget {
  final ScrollController scrollController;

  const AppointmentsTab({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppointmentsCalendar(),
            const SizedBox(height: 24),
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
            // Placeholder for upcoming appointments list
            ...List.generate(
              3,
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.2),
                  ),
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
                      child: Icon(
                        Icons.medical_services,
                        color: AppColors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Sample Doctor ${i + 1}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.coal,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'General Checkup',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '10:00 AM',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tomorrow',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.grey),
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
                        final phoneNumber = '+916290597853';
                        final uri = Uri.parse('tel:$phoneNumber');
                        try {
                          await launchUrl(uri);
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Could not launch phone dialer',
                                ),
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
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
