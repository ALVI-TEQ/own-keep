import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/document_provider.dart';
import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class SecurityAuditScreen extends ConsumerStatefulWidget {
  const SecurityAuditScreen({super.key});

  @override
  ConsumerState<SecurityAuditScreen> createState() =>
      _SecurityAuditScreenState();
}

class _SecurityAuditScreenState extends ConsumerState<SecurityAuditScreen> {
  late Future<List<bool>> _deviceChecksFuture;

  @override
  void initState() {
    super.initState();
    _deviceChecksFuture = _deviceChecks();
  }

  Future<List<bool>> _deviceChecks() async => [
    await ref.read(vaultLifecycleProvider).biometricEnabled(),
    await ref.read(pinCredentialStoreProvider).isEnrolled(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final documents = ref.watch(allDocumentsProvider);
    final unlocked = ref.watch(vaultSessionProvider).value != null;
    final preferences = ref.watch(ingestionControllerProvider)?.preferences;
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Security audit'),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              ref.invalidate(allDocumentsProvider);
              _deviceChecksFuture = _deviceChecks();
            }),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<bool>>(
        future: _deviceChecksFuture,
        builder: (context, deviceSnapshot) {
          final biometric = deviceSnapshot.data?[0];
          final pin = deviceSnapshot.data?[1];
          final items = documents.value ?? const [];
          final failed = items
              .where(
                (item) => !{
                  'VERIFIED',
                  'VALID',
                  'OK',
                }.contains(item.integrityStatus.toUpperCase()),
              )
              .length;
          final checks = <_AuditCheck>[
            _AuditCheck(
              'Vault encryption',
              unlocked
                  ? 'Encrypted vault is unlocked for this session.'
                  : 'Vault is currently locked.',
              unlocked,
              '/features/encryption-details',
            ),
            _AuditCheck(
              'PIN credential',
              pin == null
                  ? 'Checking…'
                  : pin
                  ? 'Encrypted PIN credential is enrolled.'
                  : 'PIN credential is not enrolled.',
              pin == true,
              '/features/app-lock',
            ),
            _AuditCheck(
              'Biometric unlock',
              biometric == null
                  ? 'Checking…'
                  : biometric
                  ? 'Device-bound biometric unlock is enabled.'
                  : 'Biometric unlock is not enabled.',
              biometric == true,
              '/features/app-lock',
            ),
            _AuditCheck(
              'Document integrity',
              documents.isLoading
                  ? 'Checking encrypted records…'
                  : failed == 0
                  ? '${items.length} records report valid integrity.'
                  : '$failed records need attention.',
              !documents.isLoading && failed == 0,
              '/features/data-check',
            ),
            _AuditCheck(
              'Portable backup',
              preferences?.lastBackupAt == null
                  ? 'No successful portable backup has been recorded.'
                  : 'Last successful backup: '
                        '${preferences!.lastBackupAt!.toLocal().toString().split('.')[0]} '
                        '(${preferences.lastBackupObjectCount ?? 0} objects).',
              preferences?.lastBackupAt != null,
              '/features/backup-restore',
            ),
          ];
          final completed = checks.where((item) => item.ok).length;
          final score = (completed / checks.length * 100).round();
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 72,
                  backgroundColor: score >= 80
                      ? colors.successGreen
                      : colors.warningOrange,
                  child: CircleAvatar(
                    radius: 62,
                    backgroundColor: colors.surfacePrimary,
                    child: Text(
                      '$score',
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text('$completed of ${checks.length} checks passed'),
              ),
              const SizedBox(height: 28),
              ...checks.map(
                (check) => Card(
                  child: ListTile(
                    leading: Icon(
                      check.ok ? Icons.check_circle : Icons.error_outline,
                      color: check.ok
                          ? colors.successGreen
                          : colors.warningOrange,
                    ),
                    title: Text(check.title),
                    subtitle: Text(check.detail),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(check.route),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

final class _AuditCheck {
  const _AuditCheck(this.title, this.detail, this.ok, this.route);
  final String title;
  final String detail;
  final bool ok;
  final String route;
}
