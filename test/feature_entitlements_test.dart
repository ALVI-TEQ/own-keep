import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/domain/subscription/feature_entitlements.dart';

void main() {
  test('free plan includes core vault and backup capabilities', () {
    expect(
      OwnKeepFeatureCatalog.allows(
        OwnKeepPlan.free,
        OwnKeepFeature.encryptedVault,
      ),
      isTrue,
    );
    expect(
      OwnKeepFeatureCatalog.allows(
        OwnKeepPlan.free,
        OwnKeepFeature.backupRestoreAndExport,
      ),
      isTrue,
    );
  });

  test('advanced features require pro in the plan matrix', () {
    expect(
      OwnKeepFeatureCatalog.allows(OwnKeepPlan.free, OwnKeepFeature.onDeviceAi),
      isFalse,
    );
    expect(
      OwnKeepFeatureCatalog.allows(OwnKeepPlan.pro, OwnKeepFeature.onDeviceAi),
      isTrue,
    );
    expect(
      OwnKeepFeatureCatalog.allows(
        OwnKeepPlan.pro,
        OwnKeepFeature.securityAudit,
      ),
      isTrue,
    );
  });

  test('catalog contains one definition for every feature', () {
    expect(
      OwnKeepFeatureCatalog.definitions.map((item) => item.feature).toSet(),
      OwnKeepFeature.values.toSet(),
    );
  });
}
