import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/router/app_router.dart';
import 'package:medico24/core/theme/app_colors.dart';

class HomeTopBar extends StatelessWidget {
  final bool isVisible;
  final double opacity;
  final CurrentLocationData? currentLocation;
  final User? currentUser;

  const HomeTopBar({
    super.key,
    required this.isVisible,
    required this.opacity,
    required this.currentLocation,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        heightFactor: isVisible ? 1.0 : 0.0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Location section
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.push(AppRouter.locationSelection),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.grey,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    currentLocation?.title ?? 'Select location',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppColors.coal,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.coal,
                                    size: 20,
                                  ),
                                ],
                              ),
                              Text(
                                currentLocation?.address ?? 'Tap to select',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppColors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bookmark icon
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border,
                    color: AppColors.coal,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                // User profile
                GestureDetector(
                  onTap: () => context.push(AppRouter.profile),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.red,
                    backgroundImage: currentUser?.photoURL != null
                        ? NetworkImage(currentUser!.photoURL!)
                        : null,
                    child: currentUser?.photoURL == null
                        ? Text(
                            currentUser?.displayName
                                    ?.substring(0, 1)
                                    .toUpperCase() ??
                                'U',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
