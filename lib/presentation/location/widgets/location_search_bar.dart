import 'package:flutter/material.dart';
import 'package:medico24/core/theme/app_colors.dart';

/// Search bar widget for location search
class LocationSearchBar extends StatelessWidget {
  const LocationSearchBar({
    required this.controller,
    required this.onChanged,
    required this.onClear,
    super.key,
  });
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.3)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: AppColors.coal),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search for area, street name...',
          hintStyle: const TextStyle(color: AppColors.grey),
          prefixIcon: const Icon(Icons.search, color: AppColors.red),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.grey),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
