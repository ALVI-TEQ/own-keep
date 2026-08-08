import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/subscription/feature_entitlements.dart';
import '../../providers/subscription_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class OwnKeepProScreen extends ConsumerWidget {
  const OwnKeepProScreen({super.key, this.returnTo});

  final String? returnTo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.mainColors;
    final plan = ref.watch(ownKeepPlanProvider);
    final proFeatures = OwnKeepFeatureCatalog.definitions.where(
      (item) => item.minimumPlan == OwnKeepPlan.pro,
    );
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('OwnKeep Pro'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7147E8), Color(0xFF315BD6)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Icon(Icons.workspace_premium, size: 52),
                const SizedBox(height: 12),
                Text(
                  plan == OwnKeepPlan.pro
                      ? 'OwnKeep Pro is active'
                      : 'Unlock every Pro feature',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Test subscription • ₹499/year',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),
                if (plan == OwnKeepPlan.free)
                  FilledButton(
                    onPressed: () => _showTestPlayPurchase(context, ref),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF315BD6),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Continue with Google Play'),
                  )
                else
                  const Chip(
                    avatar: Icon(Icons.check_circle, color: Colors.green),
                    label: Text('All Pro features enabled'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.science_outlined),
              title: Text('Developer test purchase'),
              subtitle: Text(
                'No money is charged and Google Play Billing is not contacted.',
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (plan == OwnKeepPlan.pro) ...[
            Text(
              'Pro feature centre',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _destination(
              context,
              Icons.auto_awesome,
              'On-device intelligence',
              'AI organize, chat, insights, tags and timeline',
              '/features/ai-organize',
            ),
            _destination(
              context,
              Icons.document_scanner_outlined,
              'OCR and document tools',
              'Open a document to extract text, or compare records',
              '/dashboard/all-files',
            ),
            _destination(
              context,
              Icons.manage_search,
              'Advanced search',
              'Filters, duplicates and vault statistics',
              '/features/advanced-search',
            ),
            _destination(
              context,
              Icons.folder_copy_outlined,
              'Custom collections',
              'Create unlimited encrypted collections',
              '/dashboard/collections',
            ),
            _destination(
              context,
              Icons.devices_outlined,
              'Secure offline transfer',
              'Move an encrypted vault to another device',
              '/features/device-migration',
            ),
            _destination(
              context,
              Icons.security_outlined,
              'Advanced security audit',
              'Review vault, biometric and document integrity',
              '/features/security-audit',
            ),
            const SizedBox(height: 16),
          ],
          ...proFeatures.map(
            (item) => Card(
              color: colors.surfacePrimary,
              child: ListTile(
                leading: Icon(
                  plan == OwnKeepPlan.pro ? Icons.check_circle : Icons.star,
                  color: plan == OwnKeepPlan.pro
                      ? colors.successGreen
                      : const Color(0xFFFFB020),
                ),
                title: Text(item.title),
                subtitle: Text(item.description),
              ),
            ),
          ),
          if (plan == OwnKeepPlan.pro) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                await ref
                    .read(ownKeepPlanProvider.notifier)
                    .resetTestPurchase();
              },
              child: const Text('Reset test purchase'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _destination(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String route,
  ) => Card(
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(route),
    ),
  );

  Future<void> _showTestPlayPurchase(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final purchased = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => const _TestPlayPurchaseSheet(),
    );
    if (purchased != true || !context.mounted) return;
    await ref.read(ownKeepPlanProvider.notifier).enableTestPro();
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 52),
        title: const Text('Payment successful'),
        content: const Text(
          'Test purchase completed. All OwnKeep Pro features are now enabled.',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              final destination = returnTo;
              if (destination != null && destination.startsWith('/')) {
                context.go(destination);
              }
            },
            child: const Text('Start using Pro'),
          ),
        ],
      ),
    );
  }
}

class _TestPlayPurchaseSheet extends StatefulWidget {
  const _TestPlayPurchaseSheet();

  @override
  State<_TestPlayPurchaseSheet> createState() => _TestPlayPurchaseSheetState();
}

class _TestPlayPurchaseSheetState extends State<_TestPlayPurchaseSheet> {
  bool _processing = false;

  Future<void> _buy() async {
    setState(() => _processing = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      24,
      8,
      24,
      24 + MediaQuery.viewInsetsOf(context).bottom,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.play_arrow, color: Color(0xFF01875F), size: 32),
            SizedBox(width: 10),
            Text(
              'Google Play test checkout',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('OwnKeep Pro – Annual'),
          subtitle: Text('Dummy purchase for internal testing only'),
          trailing: Text('₹499.00'),
        ),
        const Divider(),
        const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.credit_card),
          title: Text('Test payment method'),
          subtitle: Text('Always approves • No charge'),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: _processing ? null : _buy,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF01875F),
            minimumSize: const Size.fromHeight(52),
          ),
          child: _processing
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Buy (test)'),
        ),
      ],
    ),
  );
}
