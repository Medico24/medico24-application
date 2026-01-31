import 'package:flutter/material.dart';
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
    super.key,
  });

  final ScrollController scrollController;
  final int tabIndex;
  final String tabLabel;
  final IconData tabIcon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Environment/Weather Card
          EnvironmentCard(),
          SizedBox(height: 16),

          // Find Doctor and Vet Section
          FindDoctorVetSection(),
          SizedBox(height: 16),

          // Physicians Near You
          PhysiciansNearYouSection(),
          SizedBox(height: 32),

          // Top Rated Doctors
          TopRatedDoctorsSection(),
          SizedBox(height: 32),

          // Hospitals Near You
          HospitalsNearYouSection(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
