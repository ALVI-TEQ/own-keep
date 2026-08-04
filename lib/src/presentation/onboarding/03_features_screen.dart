import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../components/ownkeep_onboarding_components.dart';
import '../../theme/app_icons.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return OwnKeepOnboardingScaffold(
      showBackButton: true,
      child: Column(
        children: [
          SizedBox(height: 32),
          OwnKeepOnboardingHeader(
            title: 'Everything you need to keep safe.', // Could be added to l10n
          ),
          SizedBox(height: 48),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OwnKeepFeatureCard(
                    icon: AppIcons.privacyShield(width: 32, height: 32),
                    title: l10n.feature1Title,
                    description: l10n.feature1Desc,
                  ),
                  OwnKeepFeatureCard(
                    icon: AppIcons.localAi(width: 32, height: 32),
                    title: l10n.feature2Title,
                    description: l10n.feature2Desc,
                  ),
                  OwnKeepFeatureCard(
                    icon: AppIcons.zeroKnowledgeLock(width: 32, height: 32),
                    title: l10n.feature3Title,
                    description: l10n.feature3Desc,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          OwnKeepGradientButton(
            text: l10n.btnContinue,
            onPressed: () => context.push('/create-vault'),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
