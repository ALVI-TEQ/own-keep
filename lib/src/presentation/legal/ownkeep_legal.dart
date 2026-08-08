import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class OwnKeepLegal {
  static const privacyUrl = 'https://alviteq.com/products/ownkeep/privacy';
  static const termsUrl = 'https://alviteq.com/products/ownkeep/terms';
  static const privacyEmail = 'privacy@alviteq.com';
  static const supportEmail = 'hello@alviteq.com';
  static const effectiveDate = '8 August 2026';
  static const agreementVersion = '2026-08-08.v2';
}

enum OwnKeepLegalDocument { privacy, terms }

class OwnKeepLegalDocumentScreen extends StatelessWidget {
  const OwnKeepLegalDocumentScreen({required this.document, super.key});

  final OwnKeepLegalDocument document;

  @override
  Widget build(BuildContext context) {
    final privacy = document == OwnKeepLegalDocument.privacy;
    final sections = privacy ? _privacySections : _termsSections;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          privacy ? 'OwnKeep Privacy Policy' : 'OwnKeep Terms & Conditions',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Effective ${OwnKeepLegal.effectiveDate}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          ...sections.map(
            (section) => Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.$1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(section.$2),
                ],
              ),
            ),
          ),
          const Divider(),
          SelectableText(
            privacy ? OwnKeepLegal.privacyUrl : OwnKeepLegal.termsUrl,
          ),
          const SizedBox(height: 8),
          SelectableText(
            privacy ? OwnKeepLegal.privacyEmail : OwnKeepLegal.supportEmail,
          ),
        ],
      ),
    );
  }
}

const _privacySections = <(String, String)>[
  (
    '1. Local-first processing',
    'OwnKeep does not create an online account or upload your vault to an OwnKeep server. The current release has no advertising, analytics, or crash-reporting SDK and does not request Internet access in production.',
  ),
  (
    '2. Information on your device',
    'Documents, photos, metadata, tags, reminders, OCR text, emergency information, and security preferences are processed locally and stored in encrypted or isolated app storage.',
  ),
  (
    '3. Device capabilities',
    'System pickers, scanning, notifications, and biometric authentication are used only when you choose the related feature. Android controls biometric templates; OwnKeep cannot read or store them.',
  ),
  (
    '4. User-controlled exports',
    'A document or encrypted backup leaves OwnKeep only after you select an export destination. That destination is governed by its provider. Never send recovery phrases or sensitive vault records to support.',
  ),
  (
    '5. Deletion',
    'Delete individual records, empty deleted items, wipe the vault, clear app storage, or uninstall OwnKeep to remove local information. Exported files must be deleted separately from their chosen destination.',
  ),
  (
    '6. Recovery and security',
    'You control your PIN, recovery phrase, device, and backups. OwnKeep cannot recover a lost recovery credential or decrypt the vault for you.',
  ),
];

const _termsSections = <(String, String)>[
  (
    '1. Acceptance',
    'By creating or using an OwnKeep vault, you agree to these terms and the OwnKeep Privacy Policy. If you do not agree, do not create a vault.',
  ),
  (
    '2. Local productivity tool',
    'OwnKeep organizes records on your device. It is not an online account, hosted vault, guaranteed recovery service, or professional records-management service.',
  ),
  (
    '3. Your responsibilities',
    'You are responsible for device access, the legality and accuracy of stored information, recovery material, exported files, and maintaining tested encrypted backups.',
  ),
  (
    '4. Data-loss risk',
    'Device failure, user deletion, clearing app storage, uninstalling, operating-system changes, missing backups, or lost recovery material can make records permanently unavailable.',
  ),
  (
    '5. No professional advice',
    'OwnKeep is not medical, legal, financial, insurance, tax, or emergency-response advice. Verify important information against authoritative records.',
  ),
  (
    '6. Availability',
    'Capabilities can vary by device, operating system, hardware, region, and app version. Website concepts and previews do not guarantee availability in the installed release.',
  ),
  (
    '7. Disclaimer',
    'To the extent permitted by law, OwnKeep is provided as available without a guarantee of uninterrupted or error-free operation. Rights and liability that cannot legally be excluded remain unaffected.',
  ),
];
