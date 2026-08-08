# Google Play Data Safety Draft

This draft describes the current production Android build. Re-audit dependencies and the merged release manifest before every Play submission.

## Recommended answers

- Does the app collect or share required user data types? **No**. In Google Play terminology, collection generally means transmitting data off the device. The release build has no Internet permission and no analytics, advertising, account, or crash-reporting SDK.
- Is all user data encrypted in transit? **Not applicable to developer collection.** User-initiated exports are encrypted where the OwnKeep backup format is used and are handed to an Android destination chosen by the user.
- Can users request data deletion? **Yes, locally.** Records can be deleted in the app and the complete local vault can be wiped. There is no OwnKeep online account or server-held user data.
- Does the app support account creation? **No.** Therefore Google Play's online account-deletion link requirement does not apply to this release.
- Has the app committed to the Families Policy? **No**, unless the store listing is intentionally targeted to children.

## User-controlled data

Documents, photos, OCR text, reminders, tags, medical/emergency information and backup files are user-provided or locally generated. They remain on device unless the user explicitly selects an export destination. A destination provider such as a file manager or external drive is outside OwnKeep's control.

## Re-audit triggers

Revisit this declaration before enabling Play Billing verification, cloud sync, remote family sharing, telemetry, crash reporting, support uploads, or any SDK capable of transmitting data.
