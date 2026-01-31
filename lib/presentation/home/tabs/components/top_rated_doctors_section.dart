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
            separatorBuilder: (_, __) => const SizedBox(width: 20),
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
  final String title;
  final VoidCallback onTap;

  const _SectionHeader({required this.title, required this.onTap});

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
  final int index;
  const _TopRatedDoctorCircle({required this.index});

  @override
  Widget build(BuildContext context) {
    final names = ['Dr. James', 'Dr. Linda', 'Dr. Alex', 'Dr. Sue'];
    final roles = ['Neurologist', 'Pediatrician', 'Surgeon', 'Dentist'];
    final images = [
      'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=200&q=80',
      'https://images.unsplash.com/photo-1594824476967-48c8b964273f?auto=format&fit=crop&w=200&q=80',
      'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=200&q=80',
      'https://images.unsplash.com/photo-1614608682850-e0d6ed316d47?auto=format&fit=crop&w=200&q=80',
    ];

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(images[index % images.length]),
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
