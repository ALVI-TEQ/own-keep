import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../theme/ownkeep_main_colors.dart';
import '../../theme/ownkeep_main_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/vault_provider.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isTyping = true;
    });
    _controller.clear();

    final response = ref.read(ingestionControllerProvider)?.askVault(text);
    setState(() {
      _isTyping = false;
      _messages.add({
        'role': 'ai',
        'text':
            response?.answerText ??
            'Unlock your vault to query its local index.',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.mainColors;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.backgroundTop,
      appBar: AppBar(
        backgroundColor: colors.backgroundTop,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            OwnKeepMainIcons.back_arrow,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            Text(
              l10n.s71_title,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              l10n.s71_subtitle,
              style: TextStyle(color: colors.primaryBlue, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.history,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: () => context.push('/features/ai-history'),
          ),
          IconButton(
            icon: SvgPicture.asset(
              OwnKeepMainIcons.settings,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            onPressed: () => context.push('/features/ai-settings'),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.backgroundTop, colors.backgroundBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            if (_messages.isEmpty) ...[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colors.primaryBlue.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          OwnKeepMainIcons.ai_sparkle,
                          colorFilter: ColorFilter.mode(
                            colors.primaryBlue,
                            BlendMode.srcIn,
                          ),
                          width: 48,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.s71_greeting,
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.s71_greeting_subtitle,
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Prompt Suggestions
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildSuggestionChip(
                              l10n.s71_prompt_insurance,
                              colors,
                            ),
                            _buildSuggestionChip(
                              l10n.s71_prompt_expenses,
                              colors,
                            ),
                            _buildSuggestionChip(
                              l10n.s71_prompt_expiry,
                              colors,
                            ),
                            _buildSuggestionChip(
                              l10n.s71_prompt_summarize,
                              colors,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length) {
                      return _buildTypingIndicator(colors);
                    }
                    final msg = _messages[index];
                    final isUser = msg['role'] == 'user';
                    return _buildMessageBubble(msg['text'], isUser, colors);
                  },
                ),
              ),
            ],

            // Input Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfacePrimary,
                border: Border(top: BorderSide(color: colors.borderSoft)),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: colors.textPrimary),
                        decoration: InputDecoration(
                          hintText: l10n.s71_input_hint,
                          hintStyle: TextStyle(color: colors.textMuted),
                          filled: true,
                          fillColor: colors.backgroundBottom,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => _sendMessage(_controller.text),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          OwnKeepMainIcons.send,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String text, OwnKeepMainColorsTheme colors) {
    return ActionChip(
      label: Text(
        text,
        style: TextStyle(color: colors.textPrimary, fontSize: 14),
      ),
      backgroundColor: colors.surfacePrimary,
      side: BorderSide(color: colors.borderSoft),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onPressed: () => _sendMessage(text),
    );
  }

  Widget _buildMessageBubble(
    String text,
    bool isUser,
    OwnKeepMainColorsTheme colors,
  ) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? colors.primaryBlue : colors.surfaceSecondary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : colors.textPrimary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(OwnKeepMainColorsTheme colors) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.surfaceSecondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(colors),
            const SizedBox(width: 4),
            _dot(colors),
            const SizedBox(width: 4),
            _dot(colors),
          ],
        ),
      ),
    );
  }

  Widget _dot(OwnKeepMainColorsTheme colors) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: colors.textMuted,
        shape: BoxShape.circle,
      ),
    );
  }
}
