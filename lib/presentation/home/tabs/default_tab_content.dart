import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medico24/core/theme/app_colors.dart';

class DefaultTabContent extends StatelessWidget {
  final ScrollController scrollController;
  final int tabIndex;
  final String tabLabel;
  final IconData tabIcon;

  const DefaultTabContent({
    super.key,
    required this.scrollController,
    required this.tabIndex,
    required this.tabLabel,
    required this.tabIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            SvgPicture.asset('assets/images/logo.svg', width: 100, height: 100),
            const SizedBox(height: 24),
            Text(
              'Welcome to Medico24',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: AppColors.coal),
            ),
            const SizedBox(height: 16),
            Text(
              'Page ${tabIndex + 1}: $tabLabel',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your health companion',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 40),
            // Add more content to make it scrollable
            ...List.generate(
              10,
              (i) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.red.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(tabIcon, color: AppColors.red, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Item ${i + 1}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.coal,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sample content for $tabLabel section',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.grey),
                          ),
                        ],
                      ),
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
