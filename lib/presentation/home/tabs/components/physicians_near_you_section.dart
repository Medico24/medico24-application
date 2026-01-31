import 'package:flutter/material.dart';
import 'package:medico24/core/theme/app_colors.dart';

class PhysiciansNearYouSection extends StatelessWidget {
  const PhysiciansNearYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Physicians Near You',
          onTap: () {
            // TODO: Navigate to physicians list
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return const _PhysicianCard();
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

class _PhysicianCard extends StatelessWidget {
  const _PhysicianCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=200&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Sarah Jen',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Cardiologist',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: AppColors.yellow,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '4.8',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '2.5 km',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Navigate to doctor profile
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.coal,
                    side: const BorderSide(color: AppColors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Profile'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to booking
                  },
                  child: const Text('Book Now'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
