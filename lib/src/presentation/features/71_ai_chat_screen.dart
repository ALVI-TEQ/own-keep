import 'package:flutter/material.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';
import '../components/ownkeep_ui_kit.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});
  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _controller = TextEditingController();
  bool _hasResponse = true;

  final _prompts = [
    (Icons.crop_square_rounded, const Color(0xFF1A3D7A), 'Find my vehicle insurance'),
    (Icons.grid_view_rounded, const Color(0xFF3D1A7A), 'Show documents expiring soon'),
    (Icons.favorite_rounded, const Color(0xFF7A1A2E), 'Summarize health reports'),
    (Icons.currency_rupee_rounded, const Color(0xFF0A4A2E), 'How much did I spend on travel?'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('AI Assistant', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
          Text('Private  •  On-device', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 12, fontFamily: 'Inter')),
        ]),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: OwnKeepColors.darkSurfaceElevated, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () => setState(() => _hasResponse = false),
              icon: Icon(Icons.refresh_rounded, color: OwnKeepColors.primary, size: 20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OwnKeepBottomNav(currentIndex: 0),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(OwnKeepSpacing.base),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(
                child: Text('Hello, Arjun 👋', style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
              ),
              SizedBox(height: 4),
              const Center(
                child: Text('How can I help with your vault?', style: TextStyle(color: OwnKeepColors.darkTextSecondary, fontSize: 14, fontFamily: 'Inter')),
              ),
              SizedBox(height: OwnKeepSpacing.xl),
              // Prompt grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: OwnKeepSpacing.sm,
                crossAxisSpacing: OwnKeepSpacing.sm,
                childAspectRatio: 2.5,
                children: _prompts.map((p) => GestureDetector(
                  onTap: () => setState(() => _hasResponse = true),
                  child: Container(
                    padding: EdgeInsets.all(OwnKeepSpacing.sm),
                    decoration: BoxDecoration(
                      color: OwnKeepColors.darkSurfaceElevated,
                      borderRadius: BorderRadius.circular(OwnKeepRadius.md),
                      border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
                    ),
                    child: Row(children: [
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(color: p.$2, borderRadius: BorderRadius.circular(8)),
                        child: Icon(p.$1, color: Colors.white.withValues(alpha: 0.8), size: 16),
                      ),
                      SizedBox(width: 8),
                      Expanded(child: Text(p.$3, style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Inter'))),
                    ]),
                  ),
                )).toList(),
              ),
              SizedBox(height: OwnKeepSpacing.xl),
              // AI response
              if (_hasResponse)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(OwnKeepSpacing.lg),
                  decoration: BoxDecoration(
                    color: OwnKeepColors.darkSurfaceElevated,
                    borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
                    border: Border.all(color: OwnKeepColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('AI', style: TextStyle(color: OwnKeepColors.primary, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Inter', letterSpacing: 1)),
                    SizedBox(height: OwnKeepSpacing.sm),
                    Text(
                      'Your vehicle insurance is in Vehicle › Documents. It expires in 15 days. I found the policy PDF and a renewal reminder.',
                      style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter', height: 1.6),
                    ),
                    SizedBox(height: OwnKeepSpacing.md),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: OwnKeepColors.primary,
                        side: const BorderSide(color: OwnKeepColors.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OwnKeepRadius.sm)),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: Text('Open Insurance Policy', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Inter')),
                    ),
                  ]),
                ),
            ]),
          ),
        ),
        // Input bar
        Container(
          margin: EdgeInsets.all(OwnKeepSpacing.base),
          padding: EdgeInsets.symmetric(horizontal: OwnKeepSpacing.md, vertical: 8),
          decoration: BoxDecoration(
            color: OwnKeepColors.darkSurfaceElevated,
            borderRadius: BorderRadius.circular(OwnKeepRadius.xl),
            border: Border.all(color: OwnKeepColors.darkBorder.withValues(alpha: 0.3)),
          ),
          child: Row(children: [
            Expanded(child: TextField(
              controller: _controller,
              style: TextStyle(color: OwnKeepColors.darkTextPrimary, fontSize: 14, fontFamily: 'Inter'),
              decoration: const InputDecoration(
                hintText: 'Ask anything...',
                hintStyle: TextStyle(color: OwnKeepColors.darkTextMuted, fontFamily: 'Inter'),
                border: InputBorder.none, isDense: true,
              ),
            )),
            Icon(Icons.mic_none_rounded, color: OwnKeepColors.darkTextMuted, size: 20),
            SizedBox(width: 8),
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF8B6CFF), OwnKeepColors.primary]), shape: BoxShape.circle),
              child: Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ]),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text('All AI processing happens on this device', style: TextStyle(color: OwnKeepColors.darkTextMuted, fontSize: 12, fontFamily: 'Inter')),
        ),
      ]),
    );
  }
}
