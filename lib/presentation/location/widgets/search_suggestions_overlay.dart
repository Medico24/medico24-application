import 'package:flutter/material.dart';
import 'package:medico24/core/services/places_service.dart';
import 'package:medico24/core/theme/app_colors.dart';

/// Dropdown overlay showing autocomplete suggestions
class SearchSuggestionsOverlay extends StatelessWidget {
  const SearchSuggestionsOverlay({
    required this.suggestions,
    required this.onSuggestionTap,
    super.key,
  });
  final List<PlaceSuggestion> suggestions;
  final Function(PlaceSuggestion) onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: suggestions.length,
          separatorBuilder: (_, __) =>
              Divider(height: 1, color: AppColors.grey.withValues(alpha: 0.2)),
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              leading: const Icon(Icons.location_on, color: AppColors.red),
              title: Text(
                suggestion.description,
                style: const TextStyle(color: AppColors.coal),
              ),
              onTap: () => onSuggestionTap(suggestion),
            );
          },
        ),
      ),
    );
  }
}
