import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as image;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfrx/pdfrx.dart' as pdfrx;
import 'package:vault_domain/vault_domain.dart';

import '../ingestion/ingestion_ui_controller.dart';
import 'document_file_transfer.dart';

/// Local, bounded PDF composition using authenticated temporary originals.
final class PdfDocumentTools {
  const PdfDocumentTools({
    this.maximumPages = 100,
    this.renderLongestEdge = 1800,
  });

  final int maximumPages;
  final int renderLongestEdge;

  Future<String> merge({
    required IngestionUiController controller,
    required List<DocumentDetailView> documents,
    String outputName = 'OwnKeep_Merged.pdf',
  }) async {
    if (documents.length < 2) return 'Select at least two PDF files.';
    final output = pw.Document();
    var totalPages = 0;
    for (final detail in documents) {
      if (detail.summary.mimeType.toLowerCase() != 'application/pdf') {
        return 'Only PDF documents can be merged.';
      }
      final lease = await controller.documentOriginal(
        detail.summary.id,
        mimeType: detail.summary.mimeType,
      );
      try {
        totalPages = await lease.usePrivatePath(
          (path) => _appendPdf(output, path, totalPages),
        );
      } finally {
        await lease.close();
      }
    }
    return _save(output, outputName);
  }

  Future<String> split({
    required IngestionUiController controller,
    required DocumentDetailView document,
    required Set<int> selectedPages,
    required PdfSplitMode mode,
  }) async {
    if (document.summary.mimeType.toLowerCase() != 'application/pdf') {
      return 'Select a PDF document.';
    }
    if (selectedPages.isEmpty) return 'Select at least one page.';
    final lease = await controller.documentOriginal(
      document.summary.id,
      mimeType: document.summary.mimeType,
    );
    try {
      return await lease.usePrivatePath((path) async {
        final source = await pdfrx.PdfDocument.openFile(path);
        try {
          final valid = selectedPages
              .where((page) => page >= 1 && page <= source.pages.length)
              .toSet();
          if (valid.isEmpty) return 'The selected pages are unavailable.';
          if (mode == PdfSplitMode.separate) {
            var saved = 0;
            for (final pageNumber in valid.toList()..sort()) {
              final output = pw.Document();
              await _appendPage(output, source.pages[pageNumber - 1]);
              final result = await _save(
                output,
                '${_baseName(document.summary.logicalFilename)}_page_$pageNumber.pdf',
              );
              if (result.startsWith('PDF saved')) saved++;
            }
            return '$saved of ${valid.length} PDF pages saved.';
          }
          final wanted = mode == PdfSplitMode.extract
              ? valid
              : {
                  for (var page = 1; page <= source.pages.length; page++)
                    if (!valid.contains(page)) page,
                };
          if (wanted.isEmpty) return 'The result would contain no pages.';
          final output = pw.Document();
          for (final pageNumber in wanted.toList()..sort()) {
            await _appendPage(output, source.pages[pageNumber - 1]);
          }
          final suffix = mode == PdfSplitMode.extract ? 'extracted' : 'removed';
          return _save(
            output,
            '${_baseName(document.summary.logicalFilename)}_$suffix.pdf',
          );
        } finally {
          await source.dispose();
        }
      });
    } finally {
      await lease.close();
    }
  }

  Future<int> pageCount({
    required IngestionUiController controller,
    required DocumentDetailView document,
  }) async {
    final lease = await controller.documentOriginal(
      document.summary.id,
      mimeType: document.summary.mimeType,
    );
    try {
      return lease.usePrivatePath((path) async {
        final pdf = await pdfrx.PdfDocument.openFile(path);
        try {
          return pdf.pages.length;
        } finally {
          await pdf.dispose();
        }
      });
    } finally {
      await lease.close();
    }
  }

  Future<int> _appendPdf(pw.Document output, String path, int current) async {
    final source = await pdfrx.PdfDocument.openFile(path);
    try {
      if (current + source.pages.length > maximumPages) {
        throw StateError('PDF tools support at most $maximumPages pages.');
      }
      for (final page in source.pages) {
        await _appendPage(output, page);
      }
      return current + source.pages.length;
    } finally {
      await source.dispose();
    }
  }

  Future<void> _appendPage(pw.Document output, pdfrx.PdfPage page) async {
    final longest = page.width > page.height ? page.width : page.height;
    final scale = renderLongestEdge / longest;
    final rendered = await page.render(
      fullWidth: (page.width * scale).clamp(1, 2400).toDouble(),
      fullHeight: (page.height * scale).clamp(1, 2400).toDouble(),
      backgroundColor: 0xffffffff,
    );
    if (rendered == null) throw StateError('A PDF page could not be rendered.');
    try {
      final bitmap = image.Image.fromBytes(
        width: rendered.width,
        height: rendered.height,
        bytes: rendered.pixels.buffer,
        numChannels: 4,
        order: image.ChannelOrder.bgra,
      );
      final png = Uint8List.fromList(image.encodePng(bitmap));
      output.addPage(
        pw.Page(
          pageFormat: PdfPageFormat(page.width, page.height, marginAll: 0),
          build: (_) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Image(pw.MemoryImage(png), fit: pw.BoxFit.fill),
          ),
        ),
      );
    } finally {
      rendered.dispose();
    }
  }

  Future<String> _save(pw.Document output, String name) async {
    final directory = await getTemporaryDirectory();
    final file = File(
      '${directory.path}/${DateTime.now().microsecondsSinceEpoch}.pdf',
    );
    try {
      await file.writeAsBytes(await output.save(), flush: true);
      final saved = await const PlatformDocumentFileTransfer().exportDocument(
        source: file,
        suggestedName: name,
        mimeType: 'application/pdf',
      );
      return saved ? 'PDF saved successfully.' : 'Save cancelled.';
    } finally {
      if (await file.exists()) await file.delete();
    }
  }

  String _baseName(String filename) {
    final trimmed = filename.trim().isEmpty
        ? 'OwnKeep_Document'
        : filename.trim();
    return trimmed.toLowerCase().endsWith('.pdf')
        ? trimmed.substring(0, trimmed.length - 4)
        : trimmed;
  }
}

enum PdfSplitMode { extract, separate, remove }
