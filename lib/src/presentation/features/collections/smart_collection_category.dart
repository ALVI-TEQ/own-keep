import 'package:flutter/material.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import '../../../theme/ownkeep_main_icons.dart';

enum SmartCollectionCategory {
  health,
  finance,
  property,
  vehicle,
  education,
  identity,
  insurance,
  travel,
  work;

  Color get color {
    switch (this) {
      case SmartCollectionCategory.health:
        return const Color(0xFFFF4C9A); // healthPink
      case SmartCollectionCategory.finance:
        return const Color(0xFF23CA89); // financeGreen
      case SmartCollectionCategory.property:
        return const Color(0xFFFFA42F); // propertyOrange
      case SmartCollectionCategory.vehicle:
        return const Color(0xFF35C7E5); // vehicleCyan
      case SmartCollectionCategory.education:
        return const Color(0xFF8548FF); // educationPurple
      case SmartCollectionCategory.identity:
        return const Color(0xFF4668FF); // identityBlue
      case SmartCollectionCategory.insurance:
        return const Color(0xFF35C7E5); // insuranceCyan
      case SmartCollectionCategory.travel:
        return const Color(0xFF35C7E5); // travelCyan
      case SmartCollectionCategory.work:
        return const Color(0xFFFFC62F); // workYellow
    }
  }

  String get icon {
    switch (this) {
      case SmartCollectionCategory.health:
        return OwnKeepMainIcons.health_heart;
      case SmartCollectionCategory.finance:
        return OwnKeepMainIcons.finance_rupee;
      case SmartCollectionCategory.property:
        return OwnKeepMainIcons.property_home;
      case SmartCollectionCategory.vehicle:
        return OwnKeepMainIcons.vehicle;
      case SmartCollectionCategory.education:
        return OwnKeepMainIcons.education_diamond;
      case SmartCollectionCategory.identity:
        return OwnKeepMainIcons.identity_badge;
      case SmartCollectionCategory.insurance:
        return OwnKeepMainIcons.insurance_document;
      case SmartCollectionCategory.travel:
        return OwnKeepMainIcons.travel_plane;
      case SmartCollectionCategory.work:
        return OwnKeepMainIcons.work_letter;
    }
  }

  String getTitle(AppLocalizations l10n) {
    switch (this) {
      case SmartCollectionCategory.health:
        return l10n.s61_title;
      case SmartCollectionCategory.finance:
        return l10n.s62_title;
      case SmartCollectionCategory.property:
        return l10n.s63_title;
      case SmartCollectionCategory.vehicle:
        return l10n.s64_title;
      case SmartCollectionCategory.education:
        return l10n.s65_title;
      case SmartCollectionCategory.identity:
        return l10n.s66_title;
      case SmartCollectionCategory.insurance:
        return l10n.s67_title;
      case SmartCollectionCategory.travel:
        return l10n.s68_title;
      case SmartCollectionCategory.work:
        return l10n.s69_title;
    }
  }

  String getSubtitle(AppLocalizations l10n) {
    switch (this) {
      case SmartCollectionCategory.health:
        return l10n.s61_subtitle;
      case SmartCollectionCategory.finance:
        return l10n.s62_subtitle;
      case SmartCollectionCategory.property:
        return l10n.s63_subtitle;
      case SmartCollectionCategory.vehicle:
        return l10n.s64_subtitle;
      case SmartCollectionCategory.education:
        return l10n.s65_subtitle;
      case SmartCollectionCategory.identity:
        return l10n.s66_subtitle;
      case SmartCollectionCategory.insurance:
        return l10n.s67_subtitle;
      case SmartCollectionCategory.travel:
        return l10n.s68_subtitle;
      case SmartCollectionCategory.work:
        return l10n.s69_subtitle;
    }
  }

  static SmartCollectionCategory? fromName(String name) {
    return SmartCollectionCategory.values
        .where((c) => c.name == name)
        .firstOrNull;
  }
}
