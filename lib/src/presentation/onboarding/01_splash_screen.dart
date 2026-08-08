import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_onboarding_colors.dart';
import '../../theme/ownkeep_onboarding_icons.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkVaultStatus();
  }

  Future<void> _checkVaultStatus() async {
    // Adding slight delay to prevent jarring transitions if very fast
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    
    try {
      final lifecycle = ref.read(vaultLifecycleProvider);
      final exists = await lifecycle.exists();
      if (!mounted) return;
      if (exists) {
        // Vault exists, go straight to unlock screen
        context.go('/lock');
      } else {
        // First time setup, stop loading and show landing UI
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: context.onboardingColors.backgroundDeep,
        body: Center(
          child: CircularProgressIndicator(
            color: context.onboardingColors.brandPurple,
          ),
        ),
      );
    }

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.onboardingColors.backgroundDeep,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              SvgPicture.asset(
                OwnKeepOnboardingIcons.brand_shield_lock,
                height: 160,
                width: 160,
              ),
              const SizedBox(height: 32),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                  children: [
                    TextSpan(
                      text: 'Own',
                      style: TextStyle(
                        color: context.onboardingColors.brandPurpleBright,
                      ),
                    ),
                    TextSpan(
                      text: 'Keep',
                      style: TextStyle(
                        color: context.onboardingColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${l10n.s01_tagline_line_1}\n${l10n.s01_tagline_line_2}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.onboardingColors.textSecondary,
                  fontSize: 20,
                  height: 1.4,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.onboardingColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.onboardingColors.borderSubtle,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      OwnKeepOnboardingIcons.shield_check_small,
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.s01_security_badge,
                      style: TextStyle(
                        color: context.onboardingColors.textSecondary,
                        fontSize: 13,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: OwnKeepOnboardingGradients.primaryButton,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: () => context.push('/welcome'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    l10n.s01_action_get_started,
                    style: TextStyle(
                      color: context.onboardingColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.push('/features/restore-vault'),
                child: Text(
                  l10n.s01_action_existing_account,
                  style: TextStyle(
                    color: context.onboardingColors.brandBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
