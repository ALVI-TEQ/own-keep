import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class OwnKeepAppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final bool showAppBar;

  const OwnKeepAppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              actions: actions,
            )
          : null,
      body: body,
    );
  }
}

class OwnKeepPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OwnKeepPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: OwnKeepColors.primaryGradient,
        borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
        boxShadow: [
          BoxShadow(
            color: OwnKeepColors.primaryPurple.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
          onTap: onPressed,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OwnKeepCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const OwnKeepCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(OwnKeepSpacing.md),
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
        border: Border.all(
          color: OwnKeepColors.surfaceHighlight,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

class OwnKeepFeatureTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const OwnKeepFeatureTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: OwnKeepSpacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(OwnKeepSpacing.md),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(OwnKeepRadius.lg),
              border: Border.all(color: OwnKeepColors.surfaceHighlight),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: OwnKeepSpacing.xs),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
