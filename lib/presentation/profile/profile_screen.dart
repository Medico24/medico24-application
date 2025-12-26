import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/router/app_router.dart';
import 'package:medico24/core/services/auth_service.dart';
import 'package:medico24/core/theme/app_colors.dart';
import 'package:medico24/presentation/accessibility/accessibility_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final AppDatabase _database = AppDatabase();
  User? _currentUser;
  String _hearingLevel = 'none';
  String _visionLevel = 'none';
  String _mobilityLevel = 'none';
  bool _isOlderPerson = false;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _loadAccessibilitySettings();
  }

  Future<void> _loadAccessibilitySettings() async {
    final settings = await _database.getAccessibilitySettings();
    if (settings != null && mounted) {
      setState(() {
        _hearingLevel = settings.hearingLevel;
        _visionLevel = settings.visionLevel;
        _mobilityLevel = settings.mobilityLevel;
        _isOlderPerson = settings.isOlderPerson;
      });
    }
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.coal),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.coal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Profile photo
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.red,
                    backgroundImage: _currentUser?.photoURL != null
                        ? NetworkImage(_currentUser!.photoURL!)
                        : null,
                    child: _currentUser?.photoURL == null
                        ? Text(
                            _currentUser?.displayName
                                    ?.substring(0, 1)
                                    .toUpperCase() ??
                                'U',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  // User info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentUser?.displayName ?? 'User',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.coal,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _currentUser?.email ?? '',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 8),
                        // Accessibility status icons
                        _buildAccessibilityIcons(),
                      ],
                    ),
                  ),
                  // Edit icon
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: AppColors.grey),
                    onPressed: () {
                      // TODO: Navigate to edit profile
                    },
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Specially Abled
            _buildSection(context, 'Specially Abled', [
              _buildListTile(
                context,
                icon: Icons.accessible,
                title: 'Accessibility Settings',
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccessibilitySettingsScreen(),
                    ),
                  );
                  // Reload accessibility settings when returning
                  _loadAccessibilitySettings();
                },
              ),
            ]),

            const Divider(height: 1),

            // Health Records
            _buildSection(context, 'Health Records', [
              _buildListTile(
                context,
                icon: Icons.event,
                title: 'Appointments',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.description,
                title: 'Prescriptions',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.assessment,
                title: 'Test Reports',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.medical_services,
                title: 'Medical History',
                onTap: () {},
              ),
            ]),

            const Divider(height: 1),

            // Preferences
            _buildSection(context, 'Preferences', [
              _buildListTile(
                context,
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.language,
                title: 'Language',
                trailing: Text(
                  'English',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                ),
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.location_on_outlined,
                title: 'Saved Addresses',
                onTap: () {},
              ),
            ]),

            const Divider(height: 1),

            // Account
            _buildSection(context, 'Account', [
              _buildListTile(
                context,
                icon: Icons.payment,
                title: 'Payment Methods',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.family_restroom,
                title: 'Family Members',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.security,
                title: 'Privacy & Security',
                onTap: () {},
              ),
            ]),

            const Divider(height: 1),

            // Support
            _buildSection(context, 'Support', [
              _buildListTile(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {},
              ),
            ]),

            const Divider(height: 1),

            // Sign out button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sign Out'),
                        content: const Text(
                          'Are you sure you want to sign out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(
                              'Sign Out',
                              style: TextStyle(color: AppColors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true && mounted) {
                      await _authService.signOut();
                      if (mounted) {
                        context.go(AppRouter.login);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.coal, size: 24),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: AppColors.coal),
      ),
      trailing:
          trailing ??
          Icon(Icons.chevron_right, color: AppColors.grey, size: 24),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  Widget _buildAccessibilityIcons() {
    final List<Widget> icons = [];

    // Older Person - Purple
    if (_isOlderPerson) {
      icons.add(
        _buildAccessibilityIcon(
          icon: Icons.elderly,
          color: const Color(0xFF9C27B0), // Purple
          label: 'Older Person',
        ),
      );
    }

    // Hearing Problem - Orange
    if (_hearingLevel != 'none') {
      icons.add(
        _buildAccessibilityIcon(
          icon: Icons.hearing_disabled,
          color: const Color(0xFFFF9800), // Orange
          label: 'Hearing',
        ),
      );
    }

    // Vision Problem - Blue
    if (_visionLevel != 'none') {
      icons.add(
        _buildAccessibilityIcon(
          icon: Icons.visibility_off,
          color: const Color(0xFF2196F3), // Blue
          label: 'Vision',
        ),
      );
    }

    // Mobility Problem - Green
    if (_mobilityLevel != 'none') {
      icons.add(
        _buildAccessibilityIcon(
          icon: Icons.accessible,
          color: const Color(0xFF4CAF50), // Green
          label: 'Mobility',
        ),
      );
    }

    // If no accessibility settings, return empty container
    if (icons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(spacing: 8, runSpacing: 4, children: icons);
  }

  Widget _buildAccessibilityIcon({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Tooltip(
      message: label,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}
