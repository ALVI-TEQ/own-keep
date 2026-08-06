import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vault_crypto/vault_crypto.dart';
import 'package:vault_database/vault_database.dart';
import 'package:vault_domain/vault_domain.dart';
import 'package:vault_platform/vault_platform.dart';
import 'vault_provider.dart';

/// Provides the SQLCipherDocumentLibrary bounded to the current Vault session.
final documentLibraryProvider = FutureProvider<SqlCipherDocumentLibrary?>((ref) async {
  final session = await ref.watch(vaultSessionProvider.future);
  if (session == null) return null;
  
  // Create a secure random generator for any operations that need it
  final random = PlatformCryptographicRandom();
  
  return SqlCipherDocumentLibrary(
    session: session.databaseSession,
    random: random,
  );
});

/// Fetches the recent documents (limited to 20 for dashboard usage)
final recentDocumentsProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];
  
  return library.listDocuments(
    const DocumentLibraryFilter(sort: DocumentSort.newest),
  );
});

/// Fetches a single document's details
final documentDetailProvider = FutureProvider.family<DocumentDetailView?, String>((ref, documentId) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return null;
  
  return library.document(documentId);
});

/// Fetches all active documents
final allDocumentsProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];
  
  return library.listDocuments(
    const DocumentLibraryFilter(sort: DocumentSort.name),
  );
});

/// Searches active documents by query
final searchDocumentsProvider = FutureProvider.family<List<DocumentListItemView>, String>((ref, query) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null || query.trim().isEmpty) return [];
  
  return library.listDocuments(
    DocumentLibraryFilter(query: query, sort: DocumentSort.newest),
  );
});

/// Fetches favorite documents
final favoriteDocumentsProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
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
final healthDocumentsProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];
  
  return library.listDocuments(
    const DocumentLibraryFilter(type: DocumentType.medicalReport, sort: DocumentSort.newest),
  );
});

/// Fetches passwords
final passwordsProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];
  
  return library.listDocuments(
    const DocumentLibraryFilter(type: DocumentType.password, sort: DocumentSort.newest),
  );
});

/// Fetches notes
final notesProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];
  
  return library.listDocuments(
    const DocumentLibraryFilter(type: DocumentType.note, sort: DocumentSort.newest),
  );
});

/// Fetches deleted (trash) documents
final trashDocumentsProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];
  
  return library.listDocuments(
    const DocumentLibraryFilter(
      deletedOnly: true,
      sort: DocumentSort.newest,
    ),
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
  
  // Calculate size
  int totalSize = 0;
  for (var doc in docs) {
    totalSize += 0; // Temporarily sizeBytes is missing in model
  }
  
  return {
    'totalSize': totalSize,
    'documentCount': docs.length,
  };
});
