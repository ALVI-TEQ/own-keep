import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/citizen_vault/intelligence/encrypted_ai_history_repository.dart';
import 'package:ownkeep/src/citizen_vault/vault/encrypted_local_state_repository.dart';
import 'package:vault_crypto/vault_crypto.dart';
import 'package:vault_database/vault_database.dart';
import 'package:vault_domain/vault_domain.dart';
import 'package:vault_ingestion/vault_ingestion.dart';

void main() {
  test(
    'AI, invitation, and emergency state survives encrypted DB reads',
    () async {
      final directory = Directory.systemTemp.createTempSync(
        'ownkeep_state_test_',
      );
      final key = SecretBytes(List<int>.generate(32, (index) => index + 1));
      final session = await EncryptedDatabaseOpener.open(
        file: File('${directory.path}/vault.db'),
        databaseKey: key,
        runInBackground: false,
      );
      key.destroy();
      addTearDown(() async {
        await session.close();
        directory.deleteSync(recursive: true);
      });

      final ai = EncryptedAiHistoryRepository(session);
      await ai.add(
        query: 'passport expiry',
        answer: 'One matching record',
        evidenceDocumentIds: const ['document-1'],
      );
      final history = await ai.list();
      expect(history.single.query, 'passport expiry');
      expect(history.single.evidenceDocumentIds, ['document-1']);

      final state = EncryptedLocalStateRepository(session);
      final invitation = OfflineInvitation(
        id: 'invite-1',
        recipientName: 'Family member',
        role: 'Adult',
        method: 'Encrypted backup file',
        createdAt: DateTime.utc(2026, 8, 8),
      );
      await state.addInvitation(invitation);
      expect(
        (await state.readInvitations()).single.recipientName,
        'Family member',
      );

      final envelope = EmergencyCardEnvelope(
        medicalRecord: const EmergencyMedicalRecord(
          fullName: 'Vault owner',
          bloodGroup: 'O+',
          allergies: '',
          medications: '',
          doctorName: '',
          doctorPhone: '',
          insuranceProvider: '',
          insurancePolicyNumber: '',
        ),
        contacts: const [
          EmergencyContact(
            name: 'Trusted person',
            relationship: 'Family',
            phone: '12345',
          ),
        ],
        lastUpdated: DateTime.utc(2026, 8, 8),
        accessLog: const ['2026-08-08T10:00:00.000Z'],
      );
      await state.saveEmergencyEnvelope(envelope);
      final restored = await state.readEmergencyEnvelope();
      expect(restored?.medicalRecord.fullName, 'Vault owner');
      expect(restored?.contacts.single.name, 'Trusted person');
      expect(restored?.accessLog, hasLength(1));
    },
  );

  test('emergency manager reports every mutation for persistence', () {
    final changes = <EmergencyCardEnvelope>[];
    final manager = EmergencyStorageManager(onChanged: changes.add);
    final current = manager.envelope;
    manager.updateEnvelope(
      medicalRecord: current.medicalRecord,
      contacts: const [],
      isEnabled: false,
    );
    manager.recordAccessEvent();
    expect(changes, hasLength(2));
    expect(changes.last.accessLog, hasLength(1));
  });
}
