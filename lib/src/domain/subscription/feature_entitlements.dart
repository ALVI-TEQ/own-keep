enum OwnKeepPlan { free, pro }

enum OwnKeepFeature {
  encryptedVault,
  pinAndBiometrics,
  documentImportAndSearch,
  tagsRemindersAndFavorites,
  backupRestoreAndExport,
  onDeviceAi,
  ocrAndDocumentCompare,
  advancedSearchAndStatistics,
  unlimitedCustomCollections,
  secureFamilyTransfer,
  securityAudit,
}

final class OwnKeepFeatureDefinition {
  const OwnKeepFeatureDefinition({
    required this.feature,
    required this.title,
    required this.description,
    required this.minimumPlan,
  });

  final OwnKeepFeature feature;
  final String title;
  final String description;
  final OwnKeepPlan minimumPlan;
}

abstract final class OwnKeepFeatureCatalog {
  static const definitions = <OwnKeepFeatureDefinition>[
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.encryptedVault,
      title: 'Encrypted local vault',
      description: 'Encrypted document storage that remains on this device.',
      minimumPlan: OwnKeepPlan.free,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.pinAndBiometrics,
      title: 'PIN and biometric lock',
      description: 'PIN recovery and device-bound biometric unlock.',
      minimumPlan: OwnKeepPlan.free,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.documentImportAndSearch,
      title: 'Import, preview and search',
      description: 'Add documents, preview them and search local metadata.',
      minimumPlan: OwnKeepPlan.free,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.tagsRemindersAndFavorites,
      title: 'Tags, reminders and favourites',
      description: 'Organize important records and upcoming dates.',
      minimumPlan: OwnKeepPlan.free,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.backupRestoreAndExport,
      title: 'Encrypted backup and export',
      description: 'Create portable backups and restore the complete vault.',
      minimumPlan: OwnKeepPlan.free,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.onDeviceAi,
      title: 'On-device intelligence',
      description: 'Local vault chat, insights, smart tags and timelines.',
      minimumPlan: OwnKeepPlan.pro,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.ocrAndDocumentCompare,
      title: 'OCR and document comparison',
      description: 'Extract local text and compare document records.',
      minimumPlan: OwnKeepPlan.pro,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.advancedSearchAndStatistics,
      title: 'Advanced search and statistics',
      description:
          'Detailed filters, duplicate discovery and vault statistics.',
      minimumPlan: OwnKeepPlan.pro,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.unlimitedCustomCollections,
      title: 'Unlimited custom collections',
      description: 'Create and customize any number of encrypted collections.',
      minimumPlan: OwnKeepPlan.pro,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.secureFamilyTransfer,
      title: 'Secure offline transfer',
      description:
          'Prepare encrypted backups for trusted family or another device.',
      minimumPlan: OwnKeepPlan.pro,
    ),
    OwnKeepFeatureDefinition(
      feature: OwnKeepFeature.securityAudit,
      title: 'Advanced security audit',
      description:
          'Check PIN, biometric, encryption and document integrity state.',
      minimumPlan: OwnKeepPlan.pro,
    ),
  ];

  static bool allows(OwnKeepPlan plan, OwnKeepFeature feature) {
    final definition = definitions.singleWhere(
      (item) => item.feature == feature,
    );
    return plan == OwnKeepPlan.pro ||
        definition.minimumPlan == OwnKeepPlan.free;
  }
}
