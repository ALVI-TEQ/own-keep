import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/presentation/features/36_duplicate_finder_screen.dart';
import 'package:vault_domain/vault_domain.dart';

void main() {
  test('duplicate finder counts duplicate copies, not unique originals', () {
    final documents = <DocumentListItemView>[
      _document('1', 'Passport.pdf', 'application/pdf'),
      _document('2', ' passport.PDF ', 'application/pdf'),
      _document('3', 'Passport.pdf', 'image/png'),
      _document('4', 'Passport.pdf', 'application/pdf'),
      _document('5', 'Insurance.pdf', 'application/pdf'),
    ];

    expect(duplicateDocumentCount(documents), 2);
  });
}

DocumentListItemView _document(String id, String name, String mimeType) =>
    DocumentListItemView(
      id: id,
      logicalFilename: name,
      documentType: DocumentType.generalDocument,
      mimeType: mimeType,
      status: 'READY',
      integrityStatus: 'VERIFIED',
      importedAt: DateTime.utc(2026),
      isFavourite: false,
      isArchived: false,
      tags: const [],
    );
