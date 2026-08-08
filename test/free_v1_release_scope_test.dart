import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String _read(String path) => File(path).readAsStringSync();

void main() {
  test('Android identity remains locked to the Play package ID', () {
    final gradle = _read('android/app/build.gradle.kts');

    expect(gradle, contains('namespace = "com.alviteq.ownkeep"'));
    expect(gradle, contains('applicationId = "com.alviteq.ownkeep"'));
  });

  test('test purchase UI does not include a real billing SDK', () {
    final router = _read('lib/src/routing/app_router.dart');
    final pubspec = _read('pubspec.yaml');
    final gradle = _read('android/app/build.gradle.kts');

    expect(router, contains("path: '/features/pro'"));
    expect(router, contains('proFeaturePaths'));
    expect(router, contains('OwnKeepPlan.free'));
    expect(pubspec, isNot(contains('in_app_purchase')));
    expect(pubspec, isNot(contains('purchases_flutter')));
    expect(gradle.toLowerCase(), isNot(contains('billingclient')));
  });

  test('free v1 manifest remains offline', () {
    final manifest = _read('android/app/src/main/AndroidManifest.xml');

    expect(manifest, isNot(contains('android.permission.INTERNET')));
  });

  test('Android host supports the local_auth biometric prompt', () {
    final activity = _read(
      'android/app/src/main/kotlin/com/alviteq/ownkeep/MainActivity.kt',
    );
    final manifest = _read('android/app/src/main/AndroidManifest.xml');

    expect(activity, contains('FlutterFragmentActivity'));
    expect(manifest, contains('android.permission.USE_BIOMETRIC'));
  });

  test('external scanner activity cannot trigger the app auto-lock', () {
    final app = _read('lib/main.dart');
    final scanner = _read(
      'lib/src/citizen_vault/ingestion/document_scanner_screen.dart',
    );

    expect(app, contains('handle.isBusy'));
    expect(scanner, contains('beginExternalActivity()'));
    expect(scanner, contains('endExternalActivity()'));
    expect(app, contains('TrustedExternalActivity.isActive'));
    expect(app, contains("queryParameters: {'returnTo': returnTo}"));
  });

  test('release documentation contains both public legal URLs', () {
    final listing = _read('docs/play_store/STORE_LISTING.md');

    expect(listing, contains('https://alviteq.com/products/ownkeep/privacy'));
    expect(listing, contains('https://alviteq.com/products/ownkeep/terms'));
  });
}
