import 'package:flutter/material.dart';
import 'package:medico24/core/theme/app_colors.dart';

/// Draggable bottom sheet containing address form
class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({
    required this.scrollController,
    required this.onUseCurrentLocation,
    required this.onSelectLocation,
    required this.selectedLocation,
    required this.selectedCity,
    required this.address,
    required this.addressDetailsController,
    required this.phoneController,
    required this.selectedAddressType,
    required this.onAddressTypeChanged,
    required this.onSaveAddress,
    super.key,
  });
  final ScrollController scrollController;
  final VoidCallback onUseCurrentLocation;
  final VoidCallback onSelectLocation;
  final String selectedLocation;
  final String selectedCity;
  final String address;
  final TextEditingController addressDetailsController;
  final TextEditingController phoneController;
  final String selectedAddressType;
  final void Function(String) onAddressTypeChanged;
  final VoidCallback onSaveAddress;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Use current location button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton.icon(
              onPressed: onUseCurrentLocation,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                side: const BorderSide(color: AppColors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(
                Icons.my_location,
                color: AppColors.red,
                size: 20,
              ),
              label: const Text(
                'Use current location',
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Delivery details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delivery details',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Selected location
                  InkWell(
                    onTap: onSelectLocation,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.red,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedLocation,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: AppColors.coal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (selectedCity.isNotEmpty)
                                  Text(
                                    selectedCity,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: AppColors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                if (address != 'Fetching address...' &&
                                    address != 'Unable to fetch address')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      address,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.grey,
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Address details input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: addressDetailsController,
                      maxLines: 3,
                      style: const TextStyle(color: AppColors.coal),
                      decoration: InputDecoration(
                        hintText: 'Address details*',
                        hintStyle: const TextStyle(color: AppColors.grey),
                        helperText: 'E.g. Floor, House no.',
                        helperStyle: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.red),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Receiver details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Receiver details for this address',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Phone number
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: AppColors.coal,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(color: AppColors.coal),
                            decoration: const InputDecoration(
                              hintText: 'Phone number',
                              hintStyle: TextStyle(color: AppColors.grey),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.grey),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Save address as
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Save address as',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Address type chips
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _AddressTypeChip(
                          label: 'Home',
                          icon: Icons.home,
                          isSelected: selectedAddressType == 'Home',
                          onTap: () => onAddressTypeChanged('Home'),
                        ),
                        const SizedBox(width: 12),
                        _AddressTypeChip(
                          label: 'Work',
                          icon: Icons.work,
                          isSelected: selectedAddressType == 'Work',
                          onTap: () => onAddressTypeChanged('Work'),
                        ),
                        const SizedBox(width: 12),
                        _AddressTypeChip(
                          label: 'Other',
                          icon: Icons.location_on,
                          isSelected: selectedAddressType == 'Other',
                          onTap: () => onAddressTypeChanged('Other'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Save address button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onSaveAddress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Save address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Address type chip widget
class _AddressTypeChip extends StatelessWidget {
  const _AddressTypeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.red : AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppColors.red
                : AppColors.grey.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppColors.white : AppColors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.coal,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
