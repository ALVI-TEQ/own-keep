import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../components/ownkeep_onboarding_components.dart';
import '../../theme/app_icons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return OwnKeepOnboardingScaffold(
      child: Column(
        children: [
          SizedBox(height: 32),
          Image.asset('assets/splash_icon.png', width: 240, fit: BoxFit.contain),
          SizedBox(height: 32),
          OwnKeepOnboardingHeader(
            title: l10n.welcomeTitle,
            subtitle: l10n.welcomeSubtitle,
          ),
          SizedBox(height: 48),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OwnKeepFeatureCard(
                    icon: AppIcons.offlineWifi(width: 32, height: 32),
                    title: l10n.feature1Title,
                    description: l10n.feature1Desc,
                  ),
                  OwnKeepFeatureCard(
                    icon: AppIcons.encryptedLock(width: 32, height: 32),
                    title: l10n.feature3Title,
                    description: l10n.feature3Desc,
                  ),
                  OwnKeepFeatureCard(
                    icon: AppIcons.privacyHeart(width: 32, height: 32),
                    title: l10n.feature1Title, // Replace with "Yours Forever" string if available, using feature1 as placeholder for privacy
                    description: l10n.feature1Desc,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          OwnKeepGradientButton(
            text: l10n.btnContinue,
            onPressed: () => context.push('/features'),
          ),
          SizedBox(height: 16),
          OwnKeepSecondaryAction(
            text: 'Learn More', // Might need l10n for this later
            onPressed: () {},
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
