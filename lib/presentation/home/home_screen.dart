import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'tabs/appointments_tab.dart';
import 'tabs/default_tab_content.dart';
import 'tabs/pharmacy_tab.dart';
import 'widgets/home_top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int _selectedTabIndex = 0;
  late PageController _pageController;
  final List<ScrollController> _scrollControllers = [];
  bool _isTopBarVisible = true;
  double _topBarHeight = 1.0;
  final AppDatabase _database = AppDatabase();
  CurrentLocationData? _currentLocation;
  User? _currentUser;

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
    WidgetsBinding.instance.addObserver(this);
    _currentUser = FirebaseAuth.instance.currentUser;
    _pageController = PageController(initialPage: 0);
    for (int i = 0; i < _navTabs.length; i++) {
      final controller = ScrollController();
      controller.addListener(() => _handleScroll(controller));
      _scrollControllers.add(controller);
    }
    _loadCurrentLocation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reload location when app resumes (e.g., returning from another screen)
      _loadCurrentLocation();
    }
  }

  Future<void> _loadCurrentLocation() async {
    final location = await _database.getCurrentLocation();
    if (mounted) {
      setState(() {
        _currentLocation = location;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    _database.close();
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
            HomeTopBar(
              isVisible: _isTopBarVisible,
              opacity: _topBarHeight,
              currentLocation: _currentLocation,
              currentUser: _currentUser,
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
    // Appointments tab
    if (index == 1) {
      return AppointmentsTab(scrollController: scrollController);
    }

    // Pharmacy tab
    if (index == 3) {
      return PharmacyTabContent(scrollController: scrollController);
    }

    // Default content for other tabs
    return DefaultTabContent(
      scrollController: scrollController,
      tabIndex: index,
      tabLabel: _navTabs[index]['label'],
      tabIcon: _navTabs[index]['icon'],
    );
  }
}
