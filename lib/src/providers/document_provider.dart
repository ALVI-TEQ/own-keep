import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vault_crypto/vault_crypto.dart';
import 'package:vault_database/vault_database.dart';
import 'package:vault_domain/vault_domain.dart';
import 'vault_provider.dart';

/// Provides the SQLCipherDocumentLibrary bounded to the current Vault session.
final documentLibraryProvider = FutureProvider<SqlCipherDocumentLibrary?>((ref) async {
  final session = await ref.watch(vaultSessionProvider.future);
  if (session == null) return null;
  
  // Create a secure random generator for any operations that need it
  final random = CryptographicRandom();
  
  return SqlCipherDocumentLibrary(
    session: session,
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

/// Fetches all active documents
final allDocumentsProvider = FutureProvider<List<DocumentListItemView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];
  
  return library.listDocuments(
    const DocumentLibraryFilter(sort: DocumentSort.name),
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

/// Fetches all custom tags (Collections)
final customTagsProvider = FutureProvider<List<DocumentTagView>>((ref) async {
  final library = await ref.watch(documentLibraryProvider.future);
  if (library == null) return [];
  
  return library.listTags();
});
