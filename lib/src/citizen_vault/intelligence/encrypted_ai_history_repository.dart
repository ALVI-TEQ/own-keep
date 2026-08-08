import 'package:drift/drift.dart';
import 'package:vault_database/vault_database.dart';

final class AiHistoryEntry {
  const AiHistoryEntry({
    required this.id,
    required this.query,
    required this.answer,
    required this.createdAt,
    required this.evidenceDocumentIds,
  });

  final String id;
  final String query;
  final String answer;
  final DateTime createdAt;
  final List<String> evidenceDocumentIds;
}

/// Chat history stored inside the already encrypted SQLCipher vault database.
final class EncryptedAiHistoryRepository {
  const EncryptedAiHistoryRepository(this.session);

  final VaultDatabaseSession session;

  Future<void> add({
    required String query,
    required String answer,
    required List<String> evidenceDocumentIds,
  }) => session.write((database) async {
    await _ensureTable(database);
    final now = DateTime.now().toUtc();
    await database.customStatement(
      'INSERT INTO local_ai_history '
      '(id, query_text, answer_text, created_at, evidence_ids) '
      'VALUES (?, ?, ?, ?, ?)',
      [
        '${now.microsecondsSinceEpoch}',
        query,
        answer,
        now.toIso8601String(),
        evidenceDocumentIds.join(','),
      ],
    );
  });

  Future<List<AiHistoryEntry>> list({int limit = 100}) =>
      session.read((database) async {
        await _ensureTable(database);
        final rows = await database
            .customSelect(
              'SELECT id, query_text, answer_text, created_at, evidence_ids '
              'FROM local_ai_history ORDER BY created_at DESC LIMIT ?',
              variables: [Variable.withInt(limit.clamp(1, 500))],
            )
            .get();
        return rows
            .map(
              (row) => AiHistoryEntry(
                id: row.read<String>('id'),
                query: row.read<String>('query_text'),
                answer: row.read<String>('answer_text'),
                createdAt: DateTime.parse(row.read<String>('created_at')),
                evidenceDocumentIds: row
                    .read<String>('evidence_ids')
                    .split(',')
                    .where((id) => id.isNotEmpty)
                    .toList(),
              ),
            )
            .toList();
      });

  Future<void> clear() => session.write((database) async {
    await _ensureTable(database);
    await database.customStatement('DELETE FROM local_ai_history');
  });

  Future<void> _ensureTable(dynamic database) => database.customStatement(
    'CREATE TABLE IF NOT EXISTS local_ai_history ('
    'id TEXT PRIMARY KEY NOT NULL, '
    'query_text TEXT NOT NULL, '
    'answer_text TEXT NOT NULL, '
    'created_at TEXT NOT NULL, '
    'evidence_ids TEXT NOT NULL DEFAULT "")',
  );
}
