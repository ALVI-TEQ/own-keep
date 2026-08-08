import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import '../../theme/ownkeep_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';
import '../../providers/document_provider.dart';
import '../../citizen_vault/ingestion/document_scanner_screen.dart';

class SecureScanScreen extends ConsumerStatefulWidget {
  const SecureScanScreen({super.key});

  @override
  ConsumerState<SecureScanScreen> createState() => _SecureScanScreenState();
}

class _SecureScanScreenState extends ConsumerState<SecureScanScreen> {
  bool _flashEnabled = false;
  bool _autoCrop = true;
  bool _enhance = true;
  bool _ocr = false;
  bool _multiPage = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OwnKeepMainColorsTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black, // Camera screens are usually black
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              l10n.s60_title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              l10n.s60_subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.flash, // using flash icon
              colorFilter: ColorFilter.mode(
                _flashEnabled ? colors.warningOrange : Colors.white,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: () {
              setState(() {
                _flashEnabled = !_flashEnabled;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera Preview Area
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/main/illustrations/secure_scan_document.svg',
              fit: BoxFit.cover,
              width: 24,
              height: 24,
            ),
          ),

          // Scanner Corners overlaid on top of the preview
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Stack(
                children: [
                  // Top Left
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      OwnKeepMainIcons.scanner_corner,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      width: 32,
                    ),
                  ),
                  // Top Right (rotated)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Transform.rotate(
                      angle: 1.5708, // 90 degrees
                      child: SvgPicture.asset(
                        OwnKeepMainIcons.scanner_corner,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 32,
                      ),
                    ),
                  ),
                  // Bottom Left (rotated)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Transform.rotate(
                      angle: -1.5708, // -90 degrees
                      child: SvgPicture.asset(
                        OwnKeepMainIcons.scanner_corner,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 32,
                      ),
                    ),
                  ),
                  // Bottom Right (rotated)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Transform.rotate(
                      angle: 3.14159, // 180 degrees
                      child: SvgPicture.asset(
                        OwnKeepMainIcons.scanner_corner,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Document Detected Badge
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colors.successGreen.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.s60_detected,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Controls and Capture Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: OwnKeepSpacing.md,
                right: OwnKeepSpacing.md,
                top: OwnKeepSpacing.xl,
                bottom:
                    MediaQuery.of(context).padding.bottom + OwnKeepSpacing.lg,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.9),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mode Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildModePill(l10n.s60_document, true),
                        _buildModePill(
                          l10n.s60_multi_page,
                          _multiPage,
                          onTap: () {
                            setState(() {
                              _multiPage = !_multiPage;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: OwnKeepSpacing.lg),

                  // Capture Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Toggles column
                      Column(
                        children: [
                          _buildToggleItem(
                            l10n.s60_auto_crop,
                            _autoCrop,
                            () => setState(() => _autoCrop = !_autoCrop),
                          ),
                          const SizedBox(height: OwnKeepSpacing.sm),
                          _buildToggleItem(
                            l10n.s60_enhance,
                            _enhance,
                            () => setState(() => _enhance = !_enhance),
                          ),
                        ],
                      ),

                      // Capture Button
                      GestureDetector(
                        onTap: () async {
                          final controller = ref.read(
                            ingestionControllerProvider,
                          );
                          if (controller == null) return;
                          final saved = await Navigator.of(context).push<bool>(
                            MaterialPageRoute<bool>(
                              builder: (_) =>
                                  DocumentScannerScreen(controller: controller),
                            ),
                          );
                          if (saved != true) return;
                          ref.invalidate(allDocumentsProvider);
                          ref.invalidate(recentDocumentsProvider);
                          ref.invalidate(storageStatsProvider);
                        },
                        child: SvgPicture.asset(
                          OwnKeepMainIcons
                              .capture_button, // assuming this exists
                          width: 80,
                          height: 80,
                          placeholderBuilder: (context) => Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              color: colors.primaryBlue,
                            ),
                          ),
                        ),
                      ),

                      // OCR toggle
                      _buildToggleItem(
                        l10n.s60_ocr,
                        _ocr,
                        () => setState(() => _ocr = !_ocr),
                      ),
                    ],
                  ),
                  const SizedBox(height: OwnKeepSpacing.xl),

                  // Security Notice
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        OwnKeepMainIcons.tip_check,
                        colorFilter: ColorFilter.mode(
                          colors.successGreen,
                          BlendMode.srcIn,
                        ),
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          l10n.s60_notice,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModePill(String text, bool isSelected, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildToggleItem(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white24 : Colors.black45,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              isSelected
                  ? OwnKeepMainIcons.tip_check
                  : OwnKeepMainIcons.radio_unselected,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
