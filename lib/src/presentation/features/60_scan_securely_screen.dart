import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class SecureScanScreen extends StatefulWidget {
  const SecureScanScreen({super.key});

  @override
  State<SecureScanScreen> createState() => _SecureScanScreenState();
}

class _SecureScanScreenState extends State<SecureScanScreen> {
  bool _autoCrop = true;
  bool _enhance = true;
  bool _ocr = true;
  bool _multiPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: AppBar(
        backgroundColor: OwnKeepColors.darkBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: OwnKeepColors.darkTextPrimary),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Secure Scan', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
            Text('Capture and encrypt instantly', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.bolt_rounded, color: OwnKeepColors.primary, size: 20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(),
      body: Column(
        children: [
          // Viewfinder area
          Expanded(
            child: Container(
              margin: EdgeInsets.all(OwnKeepSpacing.base),
              decoration: BoxDecoration(
                color: OwnKeepColors.darkSurfaceElevated,
                borderRadius: BorderRadius.circular(OwnKeepRadius.xl),
                border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 240, height: 320,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAEBF0),
                        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('DOCUMENT', style: TextStyle(color: Color(0xFF1A2340), fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 1, fontFamily: 'Inter')),
                          SizedBox(height: 20),
                          ...List.generate(5, (i) => Container(
                            margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                            height: 4, decoration: BoxDecoration(color: const Color(0xFFB0B8CC), borderRadius: BorderRadius.circular(2)),
                          )),
                        ],
                      ),
                    ),
                  ),
                  // Corner brackets
                  ...[ [0.0, 0.0], [1.0, 0.0], [0.0, 1.0], [1.0, 1.0] ].map((pos) => Positioned(
                    left: pos[0] == 0.0 ? 20 : null,
                    right: pos[0] == 1.0 ? 20 : null,
                    top: pos[1] == 0.0 ? 20 : null,
                    bottom: pos[1] == 1.0 ? 20 : null,
                    child: CustomPaint(
                      size: const Size(24, 24),
                      painter: _CornerPainter(
                        flipH: pos[0] == 1.0,
                        flipV: pos[1] == 1.0,
                      ),
                    ),
                  )),
                  const Positioned(
                    bottom: 16, left: 0, right: 0,
                    child: Text('Document detected', textAlign: TextAlign.center,
                        style: TextStyle(color: OwnKeepColors.success, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                  ),
                ],
              ),
            ),
          ),
          // Toggle grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.base),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: OwnKeepSpacing.sm,
              crossAxisSpacing: OwnKeepSpacing.sm,
              childAspectRatio: 4,
              children: [
                _ToggleChip(label: 'Auto Crop', active: _autoCrop, onTap: () => setState(() => _autoCrop = !_autoCrop)),
                _ToggleChip(label: 'Enhance', active: _enhance, onTap: () => setState(() => _enhance = !_enhance)),
                _ToggleChip(label: 'OCR', active: _ocr, onTap: () => setState(() => _ocr = !_ocr)),
                _ToggleChip(label: 'Multi-page', active: _multiPage, onTap: () => setState(() => _multiPage = !_multiPage)),
              ],
            ),
          ),
          SizedBox(height: OwnKeepSpacing.xl),
          // Shutter button
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              gradient: const RadialGradient(colors: [Color(0xFF8B6CFF), OwnKeepColors.primary]),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: OwnKeepColors.primary.withValues(alpha: 0.4), blurRadius: 16, spreadRadius: 2)],
            ),
            child: const Center(child: Icon(Icons.circle, color: Colors.white, size: 28)),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          Text('Scans are encrypted before saving', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
          SizedBox(height: OwnKeepSpacing.xl),
        ],
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: OwnKeepColors.darkSurfaceElevated,
          borderRadius: BorderRadius.circular(OwnKeepRadius.sm),
          border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Inter')),
          Icon(active ? Icons.check_rounded : Icons.radio_button_unchecked_rounded,
              color: active ? OwnKeepColors.success : OwnKeepColors.darkTextMuted, size: 16),
        ]),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  const _CornerPainter({required this.flipH, required this.flipV});
  final bool flipH, flipV;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = OwnKeepColors.primary..strokeWidth = 3..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    if (!flipH && !flipV) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
      canvas.drawLine(Offset.zero, Offset(0, size.height), paint);
    } else if (flipH && !flipV) {
      canvas.drawLine(Offset(size.width, 0), Offset.zero, paint);
      canvas.drawLine(Offset(size.width, 0), Offset(size.width, size.height), paint);
    } else if (!flipH && flipV) {
      canvas.drawLine(Offset(0, size.height), Offset.zero, paint);
      canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), paint);
    } else {
      canvas.drawLine(Offset(size.width, size.height), Offset(0, size.height), paint);
      canvas.drawLine(Offset(size.width, size.height), Offset(size.width, 0), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
