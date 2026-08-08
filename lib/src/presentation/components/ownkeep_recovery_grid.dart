import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class OwnKeepRecoveryWordGrid extends StatelessWidget {
  final List<String> words;

  const OwnKeepRecoveryWordGrid({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: OwnKeepSpacing.sm,
        mainAxisSpacing: OwnKeepSpacing.sm,
      ),
      itemCount: words.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(OwnKeepRadius.sm),
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${index + 1}. ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
              Text(
                words[index],
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );
  }
}
