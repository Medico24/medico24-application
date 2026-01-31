import 'package:flutter/material.dart';
import 'package:medico24/core/theme/app_colors.dart';

class FindDoctorVetSection extends StatelessWidget {
  const FindDoctorVetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Find Doctor Section
        Expanded(child: _FindDoctorCard()),
        SizedBox(width: 16),
        // Find Vet Section
        Expanded(child: _FindVetCard()),
      ],
    );
  }
}

class _FindDoctorCard extends StatelessWidget {
  const _FindDoctorCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.red100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.red.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Image (Animated/Cartoon Sick Person)
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.network(
              'https://images.unsplash.com/photo-1582750433449-648ed127bb54?auto=format&fit=crop&w=200&q=80',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          // Text Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Find Doctor',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.coal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Find the right doctor for you',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.coal.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          // InkWell for ripple effect on tap
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // TODO: Navigate to find doctor screen
              },
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

class _FindVetCard extends StatelessWidget {
  const _FindVetCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light green
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.green.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Image (Animated/Cartoon Animal)
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.network(
              'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?auto=format&fit=crop&w=200&q=80',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          // Text Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Find Vet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.coal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Find the right vet for your pet',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.coal.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          // InkWell for ripple effect on tap
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // TODO: Navigate to find vet screen
              },
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
