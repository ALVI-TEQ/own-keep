import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class EmergencyAccessScreen extends ConsumerStatefulWidget {
  const EmergencyAccessScreen({super.key});

  @override
  ConsumerState<EmergencyAccessScreen> createState() =>
      _EmergencyAccessScreenState();
}

class _EmergencyAccessScreenState extends ConsumerState<EmergencyAccessScreen> {
  void _setEnabled(bool enabled) {
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null) return;
    final envelope = controller.emergencyStorage.envelope;
    controller.emergencyStorage.updateEnvelope(
      medicalRecord: envelope.medicalRecord,
      contacts: envelope.contacts,
      isEnabled: enabled,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final controller = ref.watch(ingestionControllerProvider);
    final envelope = controller?.emergencyStorage.envelope;
    final medical = envelope?.medicalRecord;
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Emergency access'),
      ),
      body: envelope == null
          ? const Center(
              child: Text('Unlock the vault to configure emergency access.'),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SwitchListTile(
                  value: envelope.isEnabled,
                  onChanged: _setEnabled,
                  title: const Text('Emergency card enabled'),
                  subtitle: const Text(
                    'Stored in an isolated emergency-data boundary.',
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.badge),
                    title: Text(
                      medical!.fullName.isEmpty
                          ? 'Medical identity not configured'
                          : medical.fullName,
                    ),
                    subtitle: Text(
                      'Blood group: ${medical.bloodGroup.isEmpty ? 'Not set' : medical.bloodGroup}',
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.contacts),
                    title: Text('${envelope.contacts.length} trusted contacts'),
                    onTap: () => context.push('/features/trusted-contacts'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(
                      '${envelope.accessLog.length} recorded accesses',
                    ),
                    onTap: () => context.push('/features/access-history'),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: envelope.isEnabled
                      ? () {
                          controller?.recordEmergencyAccess();
                          setState(() {});
                        }
                      : null,
                  icon: const Icon(Icons.emergency),
                  label: const Text('Record emergency-card access test'),
                ),
              ],
            ),
    );
  }
}
