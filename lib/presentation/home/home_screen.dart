import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  late PageController _pageController;
  final List<ScrollController> _scrollControllers = [];
  bool _isTopBarVisible = true;
  double _topBarHeight = 1.0;
  final AuthService _authService = AuthService();

  final List<Map<String, dynamic>> _navTabs = [
    {'icon': Icons.auto_awesome, 'label': 'FOR YOU'},
    {'icon': Icons.event, 'label': 'Appointments'},
    {'icon': Icons.document_scanner, 'label': 'Prescriptions'},
    {'icon': Icons.store, 'label': 'Pharmacy'},
    {'icon': Icons.medical_services, 'label': 'Medicines'},
    {'icon': Icons.fitness_center, 'label': 'Activities'},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    for (int i = 0; i < _navTabs.length; i++) {
      final controller = ScrollController();
      controller.addListener(() => _handleScroll(controller));
      _scrollControllers.add(controller);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleScroll(ScrollController controller) {
    if (controller.hasClients) {
      final scrollOffset = controller.offset;
      if (scrollOffset > 50 && _isTopBarVisible) {
        setState(() {
          _isTopBarVisible = false;
        });
      } else if (scrollOffset <= 10 && !_isTopBarVisible) {
        setState(() {
          _isTopBarVisible = true;
        });
      }

      // Smooth opacity animation based on scroll
      if (scrollOffset <= 50) {
        final newOpacity = 1.0 - (scrollOffset / 50).clamp(0.0, 1.0);
        if ((newOpacity - _topBarHeight).abs() > 0.01) {
          setState(() {
            _topBarHeight = newOpacity;
          });
        }
      }
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with location, bookmark, and user profile
            ClipRect(
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                heightFactor: _isTopBarVisible ? 1.0 : 0.0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _topBarHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        // Location section
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                context.push(AppRouter.locationSelection),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
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
                            backgroundColor: AppColors.grey,
                            child: Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                    onTap: () => _onTabTapped(index),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
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
            Divider(color: AppColors.grey.withValues(alpha: 0.3), height: 1),

            // Content area with PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
                itemCount: _navTabs.length,
                itemBuilder: (context, index) {
                  return _buildTabContent(index, _scrollControllers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int index, ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Medico24',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: AppColors.coal),
            ),
            const SizedBox(height: 16),
            Text(
              'Page ${index + 1}: ${_navTabs[index]['label']}',
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
                    Icon(
                      _navTabs[index]['icon'],
                      color: AppColors.red,
                      size: 32,
                    ),
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
                            'Sample content for ${_navTabs[index]['label']} section',
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
