/// OwnKeep Design System — Reusable UI Components
///
/// These widgets match the exact dark_ui mockup patterns:
/// scaffolds, section headers, list tiles with icon badges,
/// tip cards, bottom nav, donut charts, and more.
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/ownkeep_colors.dart';
import '../../theme/ownkeep_spacing.dart';
import '../../theme/ownkeep_radius.dart';

// ─────────────────────────────────────────────
// OwnKeepIconBadge — colored rounded-square icon
// ─────────────────────────────────────────────
class OwnKeepIconBadge extends StatelessWidget {
  const OwnKeepIconBadge({
    super.key,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.size = 40,
    this.iconSize = 20,
    this.useSvg = false,
    this.svgAsset,
  });

  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final double size;
  final double iconSize;
  final bool useSvg;
  final String? svgAsset;

  @override
  Widget build(BuildContext context) {
    final c = color ?? OwnKeepColors.primary;
    final bg = backgroundColor ?? c.withValues(alpha: 0.15);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(OwnKeepRadius.sm),
      ),
      child: Center(
        child: useSvg && svgAsset != null
            ? SvgPicture.asset(
                svgAsset!,
                width: iconSize,
                height: iconSize,
                colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
              )
            : Icon(icon, size: iconSize, color: c),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepSectionHeader — section label + optional action
// ─────────────────────────────────────────────
class OwnKeepSectionHeader extends StatelessWidget {
  const OwnKeepSectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: OwnKeepSpacing.base,
        right: OwnKeepSpacing.base,
        top: OwnKeepSpacing.lg,
        bottom: OwnKeepSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: OwnKeepColors.darkTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          if (actionText != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionText!,
                style: TextStyle(
                  color: OwnKeepColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepListTile — icon badge + title + subtitle + chevron
// ─────────────────────────────────────────────
class OwnKeepListTile extends StatelessWidget {
  const OwnKeepListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.folder,
    this.iconColor,
    this.svgAsset,
    this.trailing,
    this.trailingText,
    this.onTap,
    this.showChevron = true,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final String? svgAsset;
  final Widget? trailing;
  final String? trailingText;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final c = iconColor ?? OwnKeepColors.primary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: OwnKeepSpacing.base,
            vertical: OwnKeepSpacing.xs,
          ),
          padding: EdgeInsets.all(OwnKeepSpacing.md),
          decoration: BoxDecoration(
            color: OwnKeepColors.darkSurfaceElevated,
            borderRadius: BorderRadius.circular(OwnKeepRadius.md),
            border: Border.all(
              color: OwnKeepColors.darkBorder.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              OwnKeepIconBadge(
                icon: icon,
                color: c,
                useSvg: svgAsset != null,
                svgAsset: svgAsset,
              ),
              SizedBox(width: OwnKeepSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: OwnKeepColors.darkTextPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          color: OwnKeepColors.darkTextSecondary,
                          fontSize: 13,
                          fontFamily: 'Inter',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailingText != null) ...[
                Text(
                  trailingText!,
                  style: TextStyle(
                    color: OwnKeepColors.darkTextSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(width: OwnKeepSpacing.sm),
              ],
              ?trailing,
              if (showChevron)
                Icon(
                  Icons.chevron_right_rounded,
                  color: OwnKeepColors.darkTextMuted,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepTipCard — bottom info/tip banner
// ─────────────────────────────────────────────
class OwnKeepTipCard extends StatelessWidget {
  const OwnKeepTipCard({
    super.key,
    required this.text,
    this.icon = Icons.shield_outlined,
    this.iconColor,
  });

  final String text;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(OwnKeepSpacing.base),
      padding: EdgeInsets.all(OwnKeepSpacing.base),
      decoration: BoxDecoration(
        color: OwnKeepColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(OwnKeepRadius.md),
        border: Border.all(
          color: OwnKeepColors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? OwnKeepColors.primary, size: 24),
          SizedBox(width: OwnKeepSpacing.md),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: OwnKeepColors.darkTextSecondary,
                fontSize: 13,
                fontFamily: 'Inter',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepAppBar — standard app bar pattern
// ─────────────────────────────────────────────
class OwnKeepAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OwnKeepAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.actions,
  });

  final String title;
  final bool showBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: OwnKeepColors.darkBackground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: showBack
          ? IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              color: OwnKeepColors.darkTextPrimary,
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: OwnKeepColors.darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepScaffold — dark scaffold with proper AppBar
// ─────────────────────────────────────────────
class OwnKeepScaffold extends StatelessWidget {
  const OwnKeepScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBack = true,
    this.actions,
    this.showBottomNav = true,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final bool showBack;
  final List<Widget>? actions;
  final bool showBottomNav;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnKeepColors.darkBackground,
      appBar: OwnKeepAppBar(title: title, showBack: showBack, actions: actions),
      body: body,
      bottomNavigationBar: showBottomNav ? OwnKeepBottomNav() : null,
      floatingActionButton: floatingActionButton,
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepBottomNav — 5-tab bar with glowing + FAB
// ─────────────────────────────────────────────
class OwnKeepBottomNav extends StatelessWidget {
  const OwnKeepBottomNav({super.key, this.currentIndex = 0});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OwnKeepColors.darkSurface,
        border: Border(
          top: BorderSide(
            color: OwnKeepColors.darkBorder.withValues(alpha: 0.3),
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: OwnKeepSpacing.sm,
        bottom: OwnKeepSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: currentIndex == 0,
          ),
          _NavItem(
            icon: Icons.grid_view_rounded,
            label: 'Collections',
            isActive: currentIndex == 1,
          ),
          // Center FAB
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [OwnKeepColors.primary, OwnKeepColors.ai],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: OwnKeepColors.primary.withValues(alpha: 0.4),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(Icons.add_rounded, color: Colors.white, size: 28),
          ),
          _NavItem(
            icon: Icons.notifications_outlined,
            label: 'Activity',
            isActive: currentIndex == 3,
          ),
          _NavItem(
            icon: Icons.person_outline_rounded,
            label: 'Profile',
            isActive: currentIndex == 4,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? OwnKeepColors.primary
        : OwnKeepColors.darkTextMuted;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepGridAction — icon grid item (for Add Item, Quick Actions)
// ─────────────────────────────────────────────
class OwnKeepGridAction extends StatelessWidget {
  const OwnKeepGridAction({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.svgAsset,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;
  final String? svgAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = iconColor ?? OwnKeepColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(OwnKeepRadius.md),
            ),
            child: Center(
              child: svgAsset != null
                  ? SvgPicture.asset(
                      svgAsset!,
                      width: 26,
                      height: 26,
                      colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
                    )
                  : Icon(icon, color: c, size: 26),
            ),
          ),
          SizedBox(height: OwnKeepSpacing.sm),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: OwnKeepColors.darkTextSecondary,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepSuggestionChip — 2-column suggestion card (AI screens)
// ─────────────────────────────────────────────
class OwnKeepSuggestionChip extends StatelessWidget {
  const OwnKeepSuggestionChip({
    super.key,
    required this.text,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(OwnKeepSpacing.md),
        decoration: BoxDecoration(
          color: OwnKeepColors.darkSurfaceElevated,
          borderRadius: BorderRadius.circular(OwnKeepRadius.sm),
          border: Border.all(
            color: OwnKeepColors.darkBorder.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: (iconColor ?? OwnKeepColors.primary).withValues(
                    alpha: 0.15,
                  ),
                  borderRadius: BorderRadius.circular(OwnKeepRadius.xs),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: iconColor ?? OwnKeepColors.primary,
                ),
              ),
              SizedBox(width: OwnKeepSpacing.sm),
            ],
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: OwnKeepColors.darkTextPrimary,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OwnKeepProgressBar — colored linear progress indicator
// ─────────────────────────────────────────────
class OwnKeepProgressBar extends StatelessWidget {
  const OwnKeepProgressBar({
    super.key,
    required this.value,
    this.color,
    this.height = 6,
  });

  final double value;
  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        backgroundColor: OwnKeepColors.darkSurfaceMuted,
        valueColor: AlwaysStoppedAnimation(color ?? OwnKeepColors.primary),
        minHeight: height,
      ),
    );
  }
}
