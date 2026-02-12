import 'package:flutter/material.dart';
import 'package:medico24/core/theme/app_colors.dart';

class TopRatedDoctorsSection extends StatelessWidget {
  const TopRatedDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Top Rated Doctors',
          onTap: () {
            // TODO: Navigate to top rated doctors list
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return _TopRatedDoctorCircle(index: index);
            },
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(onPressed: onTap, child: const Text('See All')),
      ],
    );
  }
}

class _TopRatedDoctorCircle extends StatelessWidget {
  const _TopRatedDoctorCircle({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final names = ['Dr. James', 'Dr. Linda', 'Dr. Alex', 'Dr. Sue'];
    final roles = ['Neurologist', 'Pediatrician', 'Surgeon', 'Dentist'];

    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified,
                  color: AppColors.blue,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          names[index % names.length],
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          roles[index % roles.length],
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.coal,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 10, color: AppColors.yellow),
              const SizedBox(width: 4),
              Text(
                '5.0',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
