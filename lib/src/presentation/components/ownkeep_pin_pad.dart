import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';

class OwnKeepPinPad extends StatelessWidget {
  final void Function(String) onKeyPress;
  final VoidCallback onBackspace;

  const OwnKeepPinPad({
    super.key,
    required this.onKeyPress,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NumRow(keys: const [('1', ''), ('2', 'ABC'), ('3', 'DEF')], onPress: onKeyPress),
        SizedBox(height: 16),
        _NumRow(keys: const [('4', 'GHI'), ('5', 'JKL'), ('6', 'MNO')], onPress: onKeyPress),
        SizedBox(height: 16),
        _NumRow(keys: const [('7', 'PQRS'), ('8', 'TUV'), ('9', 'WXYZ')], onPress: onKeyPress),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 84, height: 84), // Empty space
            _NumKey(main: '0', sub: '', onPress: onKeyPress),
            _BackspaceKey(onPress: onBackspace),
          ],
        ),
      ],
    );
  }
}

class _NumRow extends StatelessWidget {
  const _NumRow({required this.keys, required this.onPress});
  final List<(String, String)> keys;
  final void Function(String) onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((k) => _NumKey(main: k.$1, sub: k.$2, onPress: onPress)).toList(),
    );
  }
}

class _NumKey extends StatelessWidget {
  const _NumKey({required this.main, required this.sub, required this.onPress});
  final String main;
  final String sub;
  final void Function(String) onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(main),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 84, height: 84,
        decoration: BoxDecoration(
          color: context.appColors.surfaceSoft,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(main, style: TextStyle(color: context.appColors.textPrimary, fontSize: 32, fontWeight: FontWeight.w400)),
            if (sub.isNotEmpty)
              Text(sub, style: TextStyle(color: context.appColors.textSecondary, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _BackspaceKey extends StatelessWidget {
  const _BackspaceKey({required this.onPress});
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 84, height: 84,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AppIcons.keypadBackspace(width: 32, height: 32),
        ),
      ),
    );
  }
}

class OwnKeepPinIndicator extends StatelessWidget {
  final int length;
  final int currentLength;

  const OwnKeepPinIndicator({super.key, required this.length, required this.currentLength});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isFilled = index < currentLength;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          width: 16, height: 16,
          decoration: BoxDecoration(
            color: isFilled ? context.appColors.textPrimary : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: isFilled ? context.appColors.textPrimary : context.appColors.borderSubtle,
              width: 2,
            ),
          ),
        );
      }),
    );
  }
}
