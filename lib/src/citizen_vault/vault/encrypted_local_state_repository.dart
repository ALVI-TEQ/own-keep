import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:vault_database/vault_database.dart';
import 'package:vault_domain/vault_domain.dart';

final class OfflineInvitation {
  const OfflineInvitation({
    required this.id,
    required this.recipientName,
    required this.role,
    required this.method,
    required this.createdAt,
    this.completed = false,
  });

  final String id;
  final String recipientName;
  final String role;
  final String method;
  final DateTime createdAt;
  final bool completed;
}

/// Small app-state records stored inside the encrypted vault database.
final class EncryptedLocalStateRepository {
  const EncryptedLocalStateRepository(this.session);

  final VaultDatabaseSession session;

  Future<String?> readValue(String key) => session.read((database) async {
    await _ensureTable(database);
    final row = await database
        .customSelect(
          'SELECT value_json FROM encrypted_app_state WHERE state_key = ?',
          variables: [Variable.withString(key)],
        )
        .getSingleOrNull();
    return row?.read<String>('value_json');
  });

  Future<void> writeValue(String key, String value) =>
      session.write((database) async {
        await _ensureTable(database);
        await database.customStatement(
          'INSERT INTO encrypted_app_state (state_key, value_json, updated_at) '
          'VALUES (?, ?, ?) ON CONFLICT(state_key) DO UPDATE SET '
          'value_json = excluded.value_json, updated_at = excluded.updated_at',
          [key, value, DateTime.now().toUtc().toIso8601String()],
        );
      });

  Future<EmergencyCardEnvelope?> readEmergencyEnvelope() async {
    final encoded = await readValue('emergency_envelope');
    if (encoded == null) return null;
    final value = jsonDecode(encoded) as Map<String, dynamic>;
    final medical = value['medical'] as Map<String, dynamic>;
    return EmergencyCardEnvelope(
      medicalRecord: EmergencyMedicalRecord(
        fullName: medical['fullName'] as String? ?? '',
        bloodGroup: medical['bloodGroup'] as String? ?? '',
        allergies: medical['allergies'] as String? ?? '',
        medications: medical['medications'] as String? ?? '',
        doctorName: medical['doctorName'] as String? ?? '',
        doctorPhone: medical['doctorPhone'] as String? ?? '',
        insuranceProvider: medical['insuranceProvider'] as String? ?? '',
        insurancePolicyNumber:
            medical['insurancePolicyNumber'] as String? ?? '',
      ),
      contacts: (value['contacts'] as List<dynamic>? ?? const []).map((item) {
        final contact = item as Map<String, dynamic>;
        return EmergencyContact(
          name: contact['name'] as String? ?? '',
          relationship: contact['relationship'] as String? ?? '',
          phone: contact['phone'] as String? ?? '',
          isPrimary: contact['isPrimary'] as bool? ?? false,
        );
      }).toList(),
      lastUpdated:
          DateTime.tryParse(value['lastUpdated'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      isEnabled: value['isEnabled'] as bool? ?? false,
      accessLog: (value['accessLog'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(),
    );
  }

  Future<void> saveEmergencyEnvelope(EmergencyCardEnvelope envelope) =>
      writeValue(
        'emergency_envelope',
        jsonEncode({
          'medical': {
            'fullName': envelope.medicalRecord.fullName,
            'bloodGroup': envelope.medicalRecord.bloodGroup,
            'allergies': envelope.medicalRecord.allergies,
            'medications': envelope.medicalRecord.medications,
            'doctorName': envelope.medicalRecord.doctorName,
            'doctorPhone': envelope.medicalRecord.doctorPhone,
            'insuranceProvider': envelope.medicalRecord.insuranceProvider,
            'insurancePolicyNumber':
                envelope.medicalRecord.insurancePolicyNumber,
          },
          'contacts': envelope.contacts
              .map(
                (contact) => {
                  'name': contact.name,
                  'relationship': contact.relationship,
                  'phone': contact.phone,
                  'isPrimary': contact.isPrimary,
                },
              )
              .toList(),
          'lastUpdated': envelope.lastUpdated.toUtc().toIso8601String(),
          'isEnabled': envelope.isEnabled,
          'accessLog': envelope.accessLog,
        }),
      );

  Future<List<OfflineInvitation>> readInvitations() async {
    final encoded = await readValue('offline_invitations');
    if (encoded == null) return const [];
    return (jsonDecode(encoded) as List<dynamic>).map((item) {
      final value = item as Map<String, dynamic>;
      return OfflineInvitation(
        id: value['id'] as String,
        recipientName: value['recipientName'] as String,
        role: value['role'] as String,
        method: value['method'] as String,
        createdAt: DateTime.parse(value['createdAt'] as String),
        completed: value['completed'] as bool? ?? false,
      );
    }).toList();
  }

  Future<void> addInvitation(OfflineInvitation invitation) async {
    final values = await readInvitations();
    await writeValue(
      'offline_invitations',
      jsonEncode([
        {
          'id': invitation.id,
          'recipientName': invitation.recipientName,
          'role': invitation.role,
          'method': invitation.method,
          'createdAt': invitation.createdAt.toUtc().toIso8601String(),
          'completed': invitation.completed,
        },
        ...values.map(
          (value) => {
            'id': value.id,
            'recipientName': value.recipientName,
            'role': value.role,
            'method': value.method,
            'createdAt': value.createdAt.toUtc().toIso8601String(),
            'completed': value.completed,
          },
        ),
      ]),
    );
  }

  Future<void> _ensureTable(dynamic database) => database.customStatement(
    'CREATE TABLE IF NOT EXISTS encrypted_app_state ('
    'state_key TEXT PRIMARY KEY NOT NULL, value_json TEXT NOT NULL, '
    'updated_at TEXT NOT NULL)',
  );
}
