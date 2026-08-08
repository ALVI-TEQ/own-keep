import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vault_domain/vault_domain.dart';

import '../../providers/vault_provider.dart';
import '../../theme/ownkeep_main_colors.dart';

class TrustedContactsScreen extends ConsumerStatefulWidget {
  const TrustedContactsScreen({super.key});

  @override
  ConsumerState<TrustedContactsScreen> createState() =>
      _TrustedContactsScreenState();
}

class _TrustedContactsScreenState extends ConsumerState<TrustedContactsScreen> {
  Future<void> _addContact() async {
    final name = TextEditingController();
    final relationship = TextEditingController();
    final phone = TextEditingController();
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add trusted contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: relationship,
              decoration: const InputDecoration(labelText: 'Relationship'),
            ),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (accepted != true ||
        name.text.trim().isEmpty ||
        phone.text.trim().isEmpty) {
      return;
    }
    final controller = ref.read(ingestionControllerProvider);
    if (controller == null) return;
    final envelope = controller.emergencyStorage.envelope;
    controller.emergencyStorage.updateEnvelope(
      medicalRecord: envelope.medicalRecord,
      contacts: [
        ...envelope.contacts,
        EmergencyContact(
          name: name.text.trim(),
          relationship: relationship.text.trim(),
          phone: phone.text.trim(),
        ),
      ],
      isEnabled: envelope.isEnabled,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final controller = ref.watch(ingestionControllerProvider);
    final contacts =
        controller?.emergencyStorage.envelope.contacts ??
        const <EmergencyContact>[];
    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Trusted contacts'),
      ),
      body: contacts.isEmpty
          ? const Center(child: Text('No trusted contacts configured.'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(contact.name.substring(0, 1).toUpperCase()),
                    ),
                    title: Text(contact.name),
                    subtitle: Text('${contact.relationship}\n${contact.phone}'),
                    isThreeLine: true,
                    trailing: contact.isPrimary ? const Icon(Icons.star) : null,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addContact,
        icon: const Icon(Icons.add),
        label: const Text('Add contact'),
      ),
    );
  }
}
