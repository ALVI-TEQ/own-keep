import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/presentation/features/74_similar_documents_screen.dart';
import 'package:ownkeep/src/presentation/features/77_auto_tagging_screen.dart';
import 'package:vault_domain/vault_domain.dart';

void main() {
  test(
    'auto tagging derives deterministic tags from persisted document type',
    () {
      expect(
        suggestedTagsForDocument(_document('passport', DocumentType.passport)),
        ['identity', 'travel', 'important'],
      );
      expect(
        suggestedTagsForDocument(
          _document('unknown', DocumentType.generalDocument),
        ),
        isEmpty,
      );
    },
  );

  test('similar groups omit document types represented only once', () {
    final groups = similarDocumentGroups([
      _document('p1', DocumentType.passport),
      _document('p2', DocumentType.passport),
      _document('i1', DocumentType.invoice),
    ]);

    expect(groups[DocumentType.passport], hasLength(2));
    expect(groups.containsKey(DocumentType.invoice), isFalse);
  });
}

DocumentListItemView _document(String id, DocumentType type) =>
    DocumentListItemView(
      id: id,
      logicalFilename: '$id.pdf',
      documentType: type,
      mimeType: 'application/pdf',
      status: 'READY',
      integrityStatus: 'VERIFIED',
      importedAt: DateTime.utc(2026),
      isFavourite: false,
      isArchived: false,
      tags: const [],
    );
