#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_dir"

expected_application_id='com.alviteq.ownkeep'

if ! rg -q "applicationId = \"${expected_application_id}\"" android/app/build.gradle.kts; then
  echo "ERROR: Android application ID must remain ${expected_application_id}."
  exit 1
fi

if [[ ! -f android/key.properties ]]; then
  echo "ERROR: android/key.properties is missing. Copy android/key.properties.example and add the upload-key values."
  exit 1
fi

if rg -q 'CHANGE_ME' android/key.properties; then
  echo "ERROR: android/key.properties still contains placeholder values."
  exit 1
fi

if ! rg -q 'https://alviteq.com/products/ownkeep/privacy' docs/play_store/PRIVACY_POLICY.md; then
  echo "ERROR: The public OwnKeep privacy-policy URL is missing from the release documentation."
  exit 1
fi

if ! rg -q 'https://alviteq.com/products/ownkeep/terms' docs/play_store/STORE_LISTING.md; then
  echo "ERROR: The public OwnKeep terms URL is missing from the release documentation."
  exit 1
fi

if rg -q "path: '/features/pro'" lib/src/routing/app_router.dart; then
  echo "ERROR: The unfinished OwnKeep Pro route is active in the free-v1 build."
  exit 1
fi

if rg -q 'in_app_purchase|purchases_flutter|billingclient' pubspec.yaml android/app/build.gradle.kts; then
  echo "ERROR: Billing code is present, but free-v1 is configured as a non-monetized release."
  exit 1
fi

if rg -q 'android.permission.INTERNET' android/app/src/main/AndroidManifest.xml; then
  echo "ERROR: Free-v1 must remain offline and must not directly request Internet access."
  exit 1
fi

if ! rg -q 'FlutterFragmentActivity' android/app/src/main/kotlin/com/alviteq/ownkeep/MainActivity.kt; then
  echo "ERROR: Android MainActivity must support the local_auth biometric prompt."
  exit 1
fi

if ! rg -q 'android.permission.USE_BIOMETRIC' android/app/src/main/AndroidManifest.xml; then
  echo "ERROR: Android biometric permission is missing."
  exit 1
fi

flutter analyze
flutter test
flutter build appbundle --release

echo "Play release preflight completed. Inspect build/app/outputs/bundle/release/app-release.aab before upload."
