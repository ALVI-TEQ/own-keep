import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../theme/ownkeep_main_colors.dart';
import '../legal/ownkeep_legal.dart';

class AboutOwnKeepScreen extends StatelessWidget {
  const AboutOwnKeepScreen({super.key});

  Future<void> _copy(BuildContext context, String value, String label) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label copied.')));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('About OwnKeep'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: colors.surfacePrimary,
            child: const Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(Icons.shield_outlined, size: 58),
                  SizedBox(height: 12),
                  Text(
                    'OwnKeep',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Text('Keep what matters. Own your data.'),
                  SizedBox(height: 6),
                  Text('Version 1.0.0 (1)'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy Policy'),
                  subtitle: const Text(OwnKeepLegal.privacyUrl),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/privacy-policy'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.gavel_outlined),
                  title: const Text('Terms & Conditions'),
                  subtitle: const Text(OwnKeepLegal.termsUrl),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/terms-conditions'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('Open-source licences'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: 'OwnKeep',
                    applicationVersion: '1.0.0 (1)',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Website'),
                  subtitle: const Text('https://alviteq.com/products/ownkeep'),
                  trailing: const Icon(Icons.copy),
                  onTap: () => _copy(
                    context,
                    'https://alviteq.com/products/ownkeep',
                    'Website address',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Support'),
                  subtitle: const Text(OwnKeepLegal.supportEmail),
                  trailing: const Icon(Icons.copy),
                  onTap: () => _copy(
                    context,
                    OwnKeepLegal.supportEmail,
                    'Support email',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(child: Text('© 2026 ALVITEQ. All rights reserved.')),
        ],
      ),
    );
  }
}
