# Personal Google Play Account Release Checklist

## Repository status

- [x] Production manifest does not directly request dangerous permissions or Internet access.
- [x] Runtime Google Fonts downloads are disabled.
- [x] Debug signing is no longer used for release builds.
- [x] Unfinished hidden-vault, decoy-vault, merge/split and cloud-sync entry points are removed from active navigation.
- [x] Privacy policy, Data Safety and store-listing drafts exist.
- [x] Final permanent application ID confirmed as `com.alviteq.ownkeep`.
- [x] Free-v1 scope is enforced: no billing SDK, purchase route or direct Internet permission.
- [x] Analyzer quality gate passes with the numbered-screen filename convention documented as intentional.
- [x] Automated tests cover the permanent package ID, offline manifest, legal URLs and free-v1 billing boundary.
- [ ] Create and securely back up the upload keystore; fill `android/key.properties` from the example.
- [x] Flutter 3.44.8 currently resolves Android `targetSdk` to API 36; recheck on submission day.
- [ ] Build and inspect the signed AAB.

## Play Console tasks

- [ ] Create and verify the personal developer account.
- [ ] Create the app and enroll in Play App Signing.
- [x] Privacy policy is live at `https://alviteq.com/products/ownkeep/privacy`.
- [x] Terms and conditions are live at `https://alviteq.com/products/ownkeep/terms`.
- [ ] Add support email, category, content rating, target audience, ads declaration and Data Safety answers.
- [ ] Upload screenshots and feature graphic that show only shipped capabilities.
- [ ] Upload the signed AAB to internal testing first.
- [ ] Run a closed test with at least 12 opted-in testers continuously for 14 days if the personal account was created after 13 November 2023.
- [ ] Collect real feedback and complete the production-access questionnaire.
- [ ] Review pre-launch report, Android vitals and policy status before production rollout.

## Current official references

- Personal-account testing: https://support.google.com/googleplay/android-developer/answer/14151465
- Data Safety: https://support.google.com/googleplay/android-developer/answer/10787469
- Account deletion: https://support.google.com/googleplay/android-developer/answer/13327111
- Target API requirements: https://developer.android.com/google/play/requirements/target-sdk

## Physical-device test script

Each tester should exercise: fresh install, vault creation, incorrect/correct PIN, biometric enable/disable where supported, imports from camera/files/photos, preview/search/tag/reminder, background auto-lock, backup export, reinstall/clean-state full restore, document deletion/wipe, notification behavior, low-storage/cancelled-picker handling and screen-reader/text-scaling behavior.
