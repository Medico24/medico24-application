import 'package:flutter/material.dart';
import 'package:medico24/core/theme/app_colors.dart';

/// Search bar widget for location search
class LocationSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const LocationSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.grey.withValues(alpha: 0.3),
        ),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.coal),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search for area, street name...',
          hintStyle: TextStyle(color: AppColors.grey),
          prefixIcon: Icon(Icons.search, color: AppColors.red),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: AppColors.grey),
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
