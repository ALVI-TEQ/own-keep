import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/platform/trusted_external_activity.dart';

void main() {
  test(
    'trusted external activities remain active until nested work ends',
    () async {
      expect(TrustedExternalActivity.isActive, isFalse);
      TrustedExternalActivity.begin();
      expect(TrustedExternalActivity.isActive, isTrue);

      await TrustedExternalActivity.run(() async {
        expect(TrustedExternalActivity.isActive, isTrue);
      });
      expect(TrustedExternalActivity.isActive, isTrue);

      TrustedExternalActivity.end();
      expect(TrustedExternalActivity.isActive, isFalse);
    },
  );
}
