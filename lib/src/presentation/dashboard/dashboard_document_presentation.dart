import 'package:vault_domain/vault_domain.dart';

import '../../theme/ownkeep_main_icons.dart';

String dashboardDocumentIcon(DocumentListItemView document) {
  final mime = document.mimeType.toLowerCase();
  if (document.documentType == DocumentType.note) return OwnKeepMainIcons.note;
  if (mime.startsWith('image/')) return OwnKeepMainIcons.file_image;
  if (mime.startsWith('video/')) return OwnKeepMainIcons.video;
  if (mime == 'application/pdf') return OwnKeepMainIcons.file_pdf;
  return OwnKeepMainIcons.file_doc;
}
