import 'package:vault_domain/vault_domain.dart';

/// Isolated storage boundary and key manager for Emergency Mode.
/// Strictly isolated from primary vault database, graph, and evidence files.
final class EmergencyStorageManager {
  /// Creates an isolated emergency storage manager.
  EmergencyStorageManager({
    EmergencyCardEnvelope? initialEnvelope,
    this.onChanged,
  }) {
    _envelope = initialEnvelope ?? _defaultEmergencyEnvelope;
  }

  EmergencyCardEnvelope _envelope = _defaultEmergencyEnvelope;
  final void Function(EmergencyCardEnvelope envelope)? onChanged;

  /// Minimized emergency envelope.
  EmergencyCardEnvelope get envelope => _envelope;

  /// Restores a previously persisted envelope without creating audit events.
  void restoreEnvelope(EmergencyCardEnvelope envelope) {
    _envelope = envelope;
  }

  /// Updates emergency medical record and contacts.
  void updateEnvelope({
    required EmergencyMedicalRecord medicalRecord,
    required List<EmergencyContact> contacts,
    bool isEnabled = true,
  }) {
    _envelope = EmergencyCardEnvelope(
      medicalRecord: medicalRecord,
      contacts: contacts,
      lastUpdated: DateTime.now(),
      isEnabled: isEnabled,
      accessLog: _envelope.accessLog,
    );
    onChanged?.call(_envelope);
  }

  /// Records an auditable emergency card access event.
  void recordAccessEvent() {
    final timestamp = DateTime.now().toIso8601String();
    final updatedLogs = List<String>.from(_envelope.accessLog)
      ..insert(0, timestamp);
    _envelope = EmergencyCardEnvelope(
      medicalRecord: _envelope.medicalRecord,
      contacts: _envelope.contacts,
      lastUpdated: _envelope.lastUpdated,
      isEnabled: _envelope.isEnabled,
      accessLog: updatedLogs,
    );
    onChanged?.call(_envelope);
  }

  /// Completely resets emergency storage envelope.
  void resetEmergencyStorage() {
    _envelope = _defaultEmergencyEnvelope;
    onChanged?.call(_envelope);
  }

  static final EmergencyCardEnvelope _defaultEmergencyEnvelope =
      EmergencyCardEnvelope(
        medicalRecord: const EmergencyMedicalRecord(
          fullName: 'Taraka Srikakolapu',
          bloodGroup: 'O +ve',
          allergies: 'Penicillin (Severe Rash)',
          medications: 'Daily Multivitamin, Antihistamine 10mg',
          doctorName: 'Dr. R. Sharma (Consultant Physician)',
          doctorPhone: '+91 98765 43210',
          insuranceProvider: 'Star Health Comprehensive Medical Policy',
          insurancePolicyNumber: 'POL-STAR-8819201',
        ),
        contacts: const <EmergencyContact>[
          EmergencyContact(
            name: 'Ananya Srikakolapu',
            relationship: 'Spouse',
            phone: '+91 91234 56789',
            isPrimary: true,
          ),
          EmergencyContact(
            name: 'Dr. R. Sharma',
            relationship: 'Primary Physician',
            phone: '+91 98765 43210',
          ),
        ],
        lastUpdated: DateTime.utc(2026, 7, 26),
      );
}
