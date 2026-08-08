import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/providers/document_provider.dart';
import 'package:ownkeep/src/presentation/dashboard/dashboard_document_presentation.dart';
import 'package:ownkeep/src/theme/ownkeep_main_icons.dart';
import 'package:vault_domain/vault_domain.dart';

void main() {
  test('dashboard file-kind filtering uses MIME type and document type', () {
    final image = _document(mimeType: 'image/jpeg');
    final pdf = _document(mimeType: 'application/pdf');
    final video = _document(mimeType: 'video/mp4');
    final note = _document(
      mimeType: 'text/plain',
      documentType: DocumentType.note,
    );

    expect(documentMatchesKind(image, DashboardFileKind.images), isTrue);
    expect(documentMatchesKind(pdf, DashboardFileKind.documents), isTrue);
    expect(documentMatchesKind(video, DashboardFileKind.videos), isTrue);
    expect(documentMatchesKind(note, DashboardFileKind.notes), isTrue);
    expect(documentMatchesKind(image, DashboardFileKind.documents), isFalse);
    expect(documentMatchesKind(pdf, DashboardFileKind.all), isTrue);
  });

  test('dashboard filter copyWith preserves unchanged selections', () {
    const initial = DashboardDocumentFilter(
      kind: DashboardFileKind.images,
      dateRange: DashboardDateRange.thisWeek,
    );

    final updated = initial.copyWith(
      sort: DashboardDocumentSort.nameDescending,
    );

    expect(updated.kind, DashboardFileKind.images);
    expect(updated.dateRange, DashboardDateRange.thisWeek);
    expect(updated.sort, DashboardDocumentSort.nameDescending);
  });

  test('document presentation selects icons from persisted MIME metadata', () {
    expect(
      dashboardDocumentIcon(_document(mimeType: 'application/pdf')),
      OwnKeepMainIcons.file_pdf,
    );
    expect(
      dashboardDocumentIcon(_document(mimeType: 'image/png')),
      OwnKeepMainIcons.file_image,
    );
    expect(
      dashboardDocumentIcon(_document(mimeType: 'video/mp4')),
      OwnKeepMainIcons.video,
    );
    expect(
      dashboardDocumentIcon(
        _document(mimeType: 'text/plain', documentType: DocumentType.note),
      ),
      OwnKeepMainIcons.note,
    );
  });
}

DocumentListItemView _document({
  required String mimeType,
  DocumentType documentType = DocumentType.generalDocument,
}) => DocumentListItemView(
  id: mimeType,
  logicalFilename: 'file',
  documentType: documentType,
  mimeType: mimeType,
  status: 'READY',
  integrityStatus: 'VERIFIED',
  importedAt: DateTime.utc(2026),
  isFavourite: false,
  isArchived: false,
  tags: const [],
);
