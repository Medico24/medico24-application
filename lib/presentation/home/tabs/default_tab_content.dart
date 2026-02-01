import 'package:flutter/material.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/presentation/environment/environment_card.dart';
import 'package:medico24/presentation/home/tabs/components/find_doctor_vet_section.dart';
import 'package:medico24/presentation/home/tabs/components/hospitals_near_you_section.dart';
import 'package:medico24/presentation/home/tabs/components/physicians_near_you_section.dart';
import 'package:medico24/presentation/home/tabs/components/top_rated_doctors_section.dart';

class DefaultTabContent extends StatelessWidget {
  const DefaultTabContent({
    required this.scrollController,
    required this.tabIndex,
    required this.tabLabel,
    required this.tabIcon,
    this.currentLocation,
    super.key,
  });

  final ScrollController scrollController;
  final int tabIndex;
  final String tabLabel;
  final IconData tabIcon;
  final CurrentLocationData? currentLocation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Environment/Weather Card - use location as key to rebuild when it changes
          EnvironmentCard(key: ValueKey(currentLocation?.id ?? 'no-location')),
          const SizedBox(height: 16),

          // Find Doctor and Vet Section
          const FindDoctorVetSection(),
          const SizedBox(height: 16),

          // Physicians Near You
          const PhysiciansNearYouSection(),
          const SizedBox(height: 32),

          // Top Rated Doctors
          const TopRatedDoctorsSection(),
          const SizedBox(height: 32),

          // Hospitals Near You
          const HospitalsNearYouSection(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
