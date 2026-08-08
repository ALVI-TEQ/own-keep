import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vault_database/vault_database.dart';
import 'package:vault_domain/vault_domain.dart';
import 'package:vault_platform/vault_platform.dart';
import 'vault_provider.dart';

/// Provides the SQLCipherDocumentLibrary bounded to the current Vault session.
final documentLibraryProvider = FutureProvider<SqlCipherDocumentLibrary?>((
  ref,
) async {
  final session = await ref.watch(vaultSessionProvider.future);
  if (session == null) return null;

  // Create a secure random generator for any operations that need it
  final random = PlatformCryptographicRandom();

  return SqlCipherDocumentLibrary(
    session: session.databaseSession,
    random: random,
  );
});

final customCollectionsProvider = FutureProvider<List<CustomCollectionView>>((
  ref,
) async {
  final library = await ref.watch(documentLibraryProvider.future);
  return library?.listCustomCollections() ?? const <CustomCollectionView>[];
});

final aiSettingsProvider = FutureProvider<Map<String, bool>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  return library?.aiSettings() ?? const <String, bool>{};
});

/// Fetches the recent documents (limited to 20 for dashboard usage)
final recentDocumentsProvider = FutureProvider<List<DocumentListItemView>>((
  ref,
) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];

  final documents = await library.listDocuments(
    const DocumentLibraryFilter(sort: DocumentSort.newest),
  );
  return documents.take(20).toList(growable: false);
});

/// Fetches a single document's details
final documentDetailProvider =
    FutureProvider.family<DocumentDetailView?, String>((ref, documentId) async {
      final library = await ref.watch(documentLibraryProvider.future);
      if (library == null) return null;

      return library.document(documentId);
    });

/// Fetches all active documents
final allDocumentsProvider = FutureProvider<List<DocumentListItemView>>((
  ref,
) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];

  return library.listDocuments(
    const DocumentLibraryFilter(sort: DocumentSort.name),
  );
});

enum DashboardFileKind { all, documents, images, videos, notes, other }

enum DashboardDateRange { anyTime, today, thisWeek, thisMonth }

enum DashboardDocumentSort {
  newest,
  oldest,
  nameAscending,
  nameDescending,
  type,
}

final class DashboardDocumentFilter {
  const DashboardDocumentFilter({
    this.kind = DashboardFileKind.all,
    this.dateRange = DashboardDateRange.anyTime,
    this.sort = DashboardDocumentSort.newest,
  });

  final DashboardFileKind kind;
  final DashboardDateRange dateRange;
  final DashboardDocumentSort sort;

  DashboardDocumentFilter copyWith({
    DashboardFileKind? kind,
    DashboardDateRange? dateRange,
    DashboardDocumentSort? sort,
  }) => DashboardDocumentFilter(
    kind: kind ?? this.kind,
    dateRange: dateRange ?? this.dateRange,
    sort: sort ?? this.sort,
  );
}

class DashboardDocumentFilterNotifier
    extends Notifier<DashboardDocumentFilter> {
  @override
  DashboardDocumentFilter build() => const DashboardDocumentFilter();

  void update(DashboardDocumentFilter value) => state = value;
  void reset() => state = const DashboardDocumentFilter();
}

final dashboardDocumentFilterProvider =
    NotifierProvider<DashboardDocumentFilterNotifier, DashboardDocumentFilter>(
      DashboardDocumentFilterNotifier.new,
    );

final filteredDocumentsProvider = FutureProvider<List<DocumentListItemView>>((
  ref,
) async {
  final filter = ref.watch(dashboardDocumentFilterProvider);
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return <DocumentListItemView>[];
  final databaseSort = switch (filter.sort) {
    DashboardDocumentSort.newest => DocumentSort.newest,
    DashboardDocumentSort.oldest => DocumentSort.oldest,
    DashboardDocumentSort.nameAscending ||
    DashboardDocumentSort.nameDescending => DocumentSort.name,
    DashboardDocumentSort.type => DocumentSort.type,
  };
  var documents = await library.listDocuments(
    DocumentLibraryFilter(sort: databaseSort),
  );
  documents = documents
      .where((document) => documentMatchesKind(document, filter.kind))
      .toList();
  final cutoff = _dateCutoff(filter.dateRange);
  if (cutoff != null) {
    documents = documents
        .where((document) => !document.importedAt.isBefore(cutoff))
        .toList();
  }
  if (filter.sort == DashboardDocumentSort.nameDescending) {
    documents = documents.reversed.toList();
  }
  return documents;
});

bool documentMatchesKind(
  DocumentListItemView document,
  DashboardFileKind kind,
) {
  final mime = document.mimeType.toLowerCase();
  return switch (kind) {
    DashboardFileKind.all => true,
    DashboardFileKind.documents =>
      mime.startsWith('application/') || mime.startsWith('text/'),
    DashboardFileKind.images => mime.startsWith('image/'),
    DashboardFileKind.videos => mime.startsWith('video/'),
    DashboardFileKind.notes => document.documentType == DocumentType.note,
    DashboardFileKind.other =>
      !mime.startsWith('application/') &&
          !mime.startsWith('text/') &&
          !mime.startsWith('image/') &&
          !mime.startsWith('video/'),
  };
}

DateTime? _dateCutoff(DashboardDateRange range) {
  final now = DateTime.now();
  return switch (range) {
    DashboardDateRange.anyTime => null,
    DashboardDateRange.today => DateTime(now.year, now.month, now.day),
    DashboardDateRange.thisWeek => DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1)),
    DashboardDateRange.thisMonth => DateTime(now.year, now.month),
  };
}

/// Searches active documents by query
final searchDocumentsProvider =
    FutureProvider.family<List<DocumentListItemView>, String>((
      ref,
      query,
    ) async {
      final library = await ref.watch(documentLibraryProvider.future);
      if (library == null || query.trim().isEmpty) return [];

      return library.listDocuments(
        DocumentLibraryFilter(query: query, sort: DocumentSort.newest),
      );
    });

/// Fetches favorite documents
final favoriteDocumentsProvider = FutureProvider<List<DocumentListItemView>>((
  ref,
) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];

  return library.listDocuments(
    const DocumentLibraryFilter(
      favouritesOnly: true,
      sort: DocumentSort.newest,
    ),
  );
});

/// Fetches health documents
final healthDocumentsProvider = FutureProvider<List<DocumentListItemView>>((
  ref,
) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];

  return library.listDocuments(
    const DocumentLibraryFilter(
      type: DocumentType.medicalReport,
      sort: DocumentSort.newest,
    ),
  );
});

/// Fetches passwords
final passwordsProvider = FutureProvider<List<DocumentListItemView>>((
  ref,
) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];

  return library.listDocuments(
    const DocumentLibraryFilter(
      type: DocumentType.password,
      sort: DocumentSort.newest,
    ),
  );
});

/// Fetches notes
final notesProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];

  return library.listDocuments(
    const DocumentLibraryFilter(
      type: DocumentType.note,
      sort: DocumentSort.newest,
    ),
  );
});

/// Fetches deleted (trash) documents
final trashDocumentsProvider = FutureProvider<List<DocumentListItemView>>((
  ref,
) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];

  return library.listDocuments(
    const DocumentLibraryFilter(deletedOnly: true, sort: DocumentSort.newest),
  );
});

/// Fetches all custom tags
final customTagsProvider = FutureProvider<List<DocumentTagView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];

  return library.listTags();
});

/// Storage Stats
final storageStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return {'totalSize': 0, 'documentCount': 0};

  final docs = await library.listDocuments(const DocumentLibraryFilter());
  final vault = await ref.watch(vaultSessionProvider.future);
  final summary = await vault?.ingestionController.storageSummary();
  return {'totalSize': summary?.totalBytes ?? 0, 'documentCount': docs.length};
});

final vaultStorageSummaryProvider = FutureProvider((ref) async {
  final vault = await ref.watch(vaultSessionProvider.future);
  return vault?.ingestionController.storageSummary();
});
