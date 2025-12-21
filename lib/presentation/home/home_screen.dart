import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> _navTabs = [
    {'icon': Icons.auto_awesome, 'label': 'FOR YOU'},
    {'icon': Icons.restaurant, 'label': 'DINING'},
    {'icon': Icons.event, 'label': 'EVENTS'},
    {'icon': Icons.movie, 'label': 'MOVIES'},
    {'icon': Icons.store, 'label': 'STORES'},
    {'icon': Icons.celebration, 'label': 'ACTIVITIES'},
    {'icon': Icons.sports_esports, 'label': 'PLAY'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with location, bookmark, and user profile
            Padding(
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
                                      'Kora',
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
                                  'Madhyamgram, Kolkata',
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
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.grey,
                    child: Icon(Icons.person, color: AppColors.white, size: 24),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  style: TextStyle(color: AppColors.coal),
                  decoration: InputDecoration(
                    hintText: 'Search for \'Cardiac Specialist\'',
                    hintStyle: TextStyle(color: AppColors.grey),
                    prefixIcon: Icon(Icons.search, color: AppColors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Navigation tabs
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _navTabs.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final tab = _navTabs[index];
                  final isSelected = _selectedTabIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            tab['icon'],
                            color: isSelected ? AppColors.blue : AppColors.grey,
                            size: 28,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tab['label'],
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: isSelected
                                      ? AppColors.blue
                                      : AppColors.grey,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Divider
            Divider(color: AppColors.grey.withOpacity(0.3), height: 1),

            // Content area
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 100,
                      color: AppColors.red,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Welcome to Medico24',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: AppColors.coal),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your health companion',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
