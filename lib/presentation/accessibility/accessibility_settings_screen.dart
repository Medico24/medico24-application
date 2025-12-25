import 'package:flutter/material.dart';
import '../../core/database/database.dart';
import '../../core/theme/app_colors.dart';

class AccessibilitySettingsScreen extends StatefulWidget {
  const AccessibilitySettingsScreen({super.key});

  @override
  State<AccessibilitySettingsScreen> createState() =>
      _AccessibilitySettingsScreenState();
}

class _AccessibilitySettingsScreenState
    extends State<AccessibilitySettingsScreen> {
  final AppDatabase _database = AppDatabase();
  String _hearingLevel = 'none';
  String _visionLevel = 'none';
  String _mobilityLevel = 'none';
  bool _isOlderPerson = false;

  // Initial values to track changes
  String _initialHearingLevel = 'none';
  String _initialVisionLevel = 'none';
  String _initialMobilityLevel = 'none';
  bool _initialIsOlderPerson = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _database.getAccessibilitySettings();
    if (settings != null && mounted) {
      setState(() {
        _hearingLevel = settings.hearingLevel;
        _visionLevel = settings.visionLevel;
        _mobilityLevel = settings.mobilityLevel;
        _isOlderPerson = settings.isOlderPerson;
        // Save initial values
        _initialHearingLevel = settings.hearingLevel;
        _initialVisionLevel = settings.visionLevel;
        _initialMobilityLevel = settings.mobilityLevel;
        _initialIsOlderPerson = settings.isOlderPerson;
      });
    }
  }

  bool get _hasChanges {
    return _hearingLevel != _initialHearingLevel ||
        _visionLevel != _initialVisionLevel ||
        _mobilityLevel != _initialMobilityLevel ||
        _isOlderPerson != _initialIsOlderPerson;
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Accessibility Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.coal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info banner
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.blue.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.blue, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'We\'ll make the app more friendly to use based on your needs.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.coal),
                        ),
                      ),
                    ],
                  ),
                ),

                // Older Person Switch
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.elderly, color: AppColors.coal, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'I am an older person',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.coal,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Switch(
                        value: _isOlderPerson,
                        onChanged: (value) {
                          setState(() {
                            _isOlderPerson = value;
                          });
                        },
                        activeColor: AppColors.blue,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Hearing section
                _buildSectionHeader(
                  context,
                  'Hearing',
                  Icons.hearing,
                  'Select level of hearing impairment if any',
                ),
                _buildRadioOption(
                  'I\'m deaf',
                  'deaf',
                  _hearingLevel,
                  (value) => setState(() => _hearingLevel = value!),
                ),
                _buildRadioOption(
                  'I\'m hard of hearing',
                  'hard',
                  _hearingLevel,
                  (value) => setState(() => _hearingLevel = value!),
                ),
                _buildRadioOption(
                  'I\'m not deaf or hard of hearing',
                  'none',
                  _hearingLevel,
                  (value) => setState(() => _hearingLevel = value!),
                ),

                const SizedBox(height: 24),

                // Vision section
                _buildSectionHeader(
                  context,
                  'Vision',
                  Icons.visibility,
                  'Select level of vision impairment if any',
                ),
                _buildRadioOption(
                  'I\'m blind',
                  'blind',
                  _visionLevel,
                  (value) => setState(() => _visionLevel = value!),
                ),
                _buildRadioOption(
                  'I have a visual impairment',
                  'impaired',
                  _visionLevel,
                  (value) => setState(() => _visionLevel = value!),
                ),
                _buildRadioOption(
                  'I\'m not blind or visually impaired',
                  'none',
                  _visionLevel,
                  (value) => setState(() => _visionLevel = value!),
                ),

                const SizedBox(height: 24),

                // Mobility section
                _buildSectionHeader(
                  context,
                  'Mobility',
                  Icons.accessible,
                  'Select level of mobility impairment if any',
                ),
                _buildRadioOption(
                  'I use a wheelchair or mobility aid',
                  'wheelchair',
                  _mobilityLevel,
                  (value) => setState(() => _mobilityLevel = value!),
                ),
                _buildRadioOption(
                  'I have a physical disability that affects my mobility',
                  'disability',
                  _mobilityLevel,
                  (value) => setState(() => _mobilityLevel = value!),
                ),
                _buildRadioOption(
                  'I do not have a physical or mobility impairment',
                  'none',
                  _mobilityLevel,
                  (value) => setState(() => _mobilityLevel = value!),
                ),

                // Bottom padding to prevent content from being hidden behind save button
                const SizedBox(height: 100),
              ],
            ),
          ),
          // Floating save button at bottom (only shown when there are changes)
          if (_hasChanges)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _database.updateAccessibilitySettings(
                        hearingLevel: _hearingLevel,
                        visionLevel: _visionLevel,
                        mobilityLevel: _mobilityLevel,
                        isOlderPerson: _isOlderPerson,
                      );
                      if (mounted) {
                        // Update initial values after saving
                        setState(() {
                          _initialHearingLevel = _hearingLevel;
                          _initialVisionLevel = _visionLevel;
                          _initialMobilityLevel = _mobilityLevel;
                          _initialIsOlderPerson = _isOlderPerson;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Accessibility settings saved'),
                            backgroundColor: AppColors.blue,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.coal, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.coal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildRadioOption(
    String title,
    String value,
    String groupValue,
    void Function(String?) onChanged,
  ) {
    final isSelected = value == groupValue;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.red.withValues(alpha: 0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.coal),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: AppColors.red,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
