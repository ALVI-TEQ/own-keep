import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class SettingsAdvancedScreen extends ConsumerStatefulWidget {
  const SettingsAdvancedScreen({super.key});

  @override
  ConsumerState<SettingsAdvancedScreen> createState() => _SettingsAdvancedScreenState();
}

class _SettingsAdvancedScreenState extends ConsumerState<SettingsAdvancedScreen> {
  bool _biometricEnabled = false;
  bool _darkMode = true;

  @override
  void initState() {
    super.initState();
    _loadState();
  }
  
  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _darkMode = prefs.getBool('app_dark_mode') ?? true;
        _biometricEnabled = prefs.getBool('app_biometric_enabled') ?? false;
      });
    }
  }

  Future<void> _toggleBiometrics(bool enable) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('app_biometric_enabled', enable);
    if (mounted) setState(() => _biometricEnabled = enable);
  }
  
  Future<void> _toggleDarkMode(bool enable) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('app_dark_mode', enable);
    ref.read(appDarkModeProvider.notifier).state = enable;
    
    if (mounted) {
      setState(() {
        _darkMode = enable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: AppBar(
        backgroundColor: OwnKeepColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: OwnKeepColors.darkTextPrimary),
        ),
        title: Text('Settings', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 4),
      body: ListView(
        children: [
          // Security section
          _SectionLabel(label: 'Security'),
          _SettingsRow(label: 'Auto Lock', value: '5 minutes'),
          _SettingsRow(label: 'Stealth Mode', value: 'Off', iconColor: OwnKeepColors.ai, icon: Icons.visibility_off_outlined),
          _SettingsRow(label: 'Decoy Vault', value: 'Not Set', iconColor: OwnKeepColors.warning, icon: Icons.layers_outlined),
          
          _SettingsToggleRow(
            label: 'Biometric Unlock',
            icon: Icons.fingerprint,
            iconColor: OwnKeepColors.success,
            value: _biometricEnabled,
            onChanged: (v) => _toggleBiometrics(v),
          ),
          _SettingsRow(label: 'PIN Protection', value: 'On', icon: Icons.lock_outline, iconColor: OwnKeepColors.success),
          _SettingsRow(label: 'Vault Encryption', value: 'AES-256', icon: Icons.enhanced_encryption_outlined, iconColor: OwnKeepColors.primary),
          
          // Display section
          _SectionLabel(label: 'Display'),
          _SettingsToggleRow(
            label: 'Dark Mode',
            icon: Icons.dark_mode_outlined,
            iconColor: OwnKeepColors.ai,
            value: _darkMode,
            onChanged: _toggleDarkMode,
          ),
          
          // Theme Color Picker
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Theme Color', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontFamily: 'Inter')),
                Row(
                  children: [
                    _ThemeColorBubble(colorName: 'blue', color: Color(0xFF4F46E5), selected: ref.watch(appThemeColorProvider) == 'blue'),
                    _ThemeColorBubble(colorName: 'green', color: Color(0xFF10B981), selected: ref.watch(appThemeColorProvider) == 'green'),
                    _ThemeColorBubble(colorName: 'red', color: Color(0xFFEF4444), selected: ref.watch(appThemeColorProvider) == 'red'),
                    _ThemeColorBubble(colorName: 'orange', color: Color(0xFFF59E0B), selected: ref.watch(appThemeColorProvider) == 'orange'),
                    _ThemeColorBubble(colorName: 'cyan', color: Color(0xFF06B6D4), selected: ref.watch(appThemeColorProvider) == 'cyan'),
                  ],
                ),
              ],
            ),
          ),
          
          GestureDetector(
            onTap: () {
              _showLanguagePicker(context, ref);
            },
            child: _SettingsRow(label: 'App Language', value: ref.watch(appLanguageProvider), icon: Icons.language, iconColor: OwnKeepColors.primary),
          ),
          
          // Data section
          _SectionLabel(label: 'Data'),
          _SettingsRow(label: 'Backup Reminders', value: 'On', icon: Icons.backup_outlined, iconColor: OwnKeepColors.primary),
          _SettingsRow(label: 'Data Check', value: 'Last check: Today', icon: Icons.health_and_safety_outlined, iconColor: OwnKeepColors.ai),
          _WipeRow(),
          
          // Advanced section
          _SectionLabel(label: 'Advanced'),
          _SettingsRow(label: 'Trusted Contacts', value: '1', icon: Icons.people_outline, iconColor: OwnKeepColors.success),
          GestureDetector(
            onTap: () => context.push('/settings/tags'),
            child: _SettingsRow(label: 'Tag Manager', icon: Icons.label_outline, iconColor: OwnKeepColors.darkTextMuted),
          ),
          _SettingsRow(label: 'Clear Cache', value: '24 MB', icon: Icons.cleaning_services_outlined, iconColor: OwnKeepColors.darkTextMuted),
          _SettingsRow(label: 'Developer Options', icon: Icons.code_outlined, iconColor: OwnKeepColors.darkTextMuted),
          _SettingsRow(label: 'Logs', icon: Icons.receipt_long_outlined, iconColor: OwnKeepColors.darkTextMuted),
          _SettingsRow(label: 'Reset All Settings', icon: Icons.restart_alt_rounded, iconColor: OwnKeepColors.darkTextMuted),
          
          SizedBox(height: 24),
          Center(
            child: Text('Version 1.0.0 (Build 42)', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
          ),
          SizedBox(height: 48),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final languages = ['English', 'Spanish', 'French', 'German', 'Italian', 'Portuguese', 'Japanese', 'Hindi'];
    showModalBottomSheet(
      context: context,
      backgroundColor: OwnKeepColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(OwnKeepRadius.lg)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: OwnKeepSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: OwnKeepColors.darkBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: OwnKeepSpacing.md),
              const Text('Select Language', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
              const SizedBox(height: OwnKeepSpacing.md),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final language = languages[index];
                    final isSelected = ref.watch(appLanguageProvider) == language;
                    return ListTile(
                      title: Text(language, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 16, fontFamily: 'Inter')),
                      trailing: isSelected ? const Icon(Icons.check, color: OwnKeepColors.primary) : null,
                      onTap: () {
                        ref.read(appLanguageProvider.notifier).state = language;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(OwnKeepSpacing.base, OwnKeepSpacing.lg, OwnKeepSpacing.base, OwnKeepSpacing.sm),
      child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.6, fontFamily: 'Inter')),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.label, this.value, this.icon, this.iconColor});
  final String label;
  final String? value;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final c = iconColor ?? OwnKeepColors.primary;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            OwnKeepIconBadge(icon: icon!, color: c, size: 36, iconSize: 18),
            SizedBox(width: OwnKeepSpacing.md),
          ],
          Expanded(child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Inter'))),
          if (value != null) ...[
            Text(value!, style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
            SizedBox(width: 4),
          ],
          Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
        ],
      ),
    );
  }
}

class _SettingsToggleRow extends StatelessWidget {
  const _SettingsToggleRow({required this.label, required this.icon, required this.iconColor, required this.value, required this.onChanged});
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.sm),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          OwnKeepIconBadge(icon: icon, color: iconColor, size: 36, iconSize: 18),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(child: Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 15, fontFamily: 'Inter'))),
          Switch(value: value, onChanged: onChanged, activeThumbColor: OwnKeepColors.primary),
        ],
      ),
    );
  }
}

class _WipeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base, vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: OwnKeepSpacing.md),
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurfaceElevated,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          OwnKeepIconBadge(icon: Icons.delete_forever_outlined, color: OwnKeepColors.danger, size: 36, iconSize: 18),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Wipe Data', style: TextStyle(color: OwnKeepColors.danger, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
                SizedBox(height: 2),
                Text('Delete all data permanently', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
        ],
      ),
    );
  }
}

class _ThemeColorBubble extends ConsumerWidget {
  final String colorName;
  final Color color;
  final bool selected;

  const _ThemeColorBubble({
    required this.colorName,
    required this.color,
    required this.selected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('app_theme_color', colorName);
        ref.read(appThemeColorProvider.notifier).state = colorName;
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selected ? Border.all(color: Colors.white, width: 2) : null,
          boxShadow: selected ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 4, spreadRadius: 1)] : [],
        ),
      ),
    );
  }
}
