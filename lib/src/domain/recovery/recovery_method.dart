enum RecoveryMethod { generatedPhrase, customPassphrase, legacyCode }

const minimumNewCustomRecoveryCharacters = 16;

String normalizeRecoveryCredential(String value, RecoveryMethod method) {
  final trimmed = value.trim();
  if (method == RecoveryMethod.generatedPhrase) {
    return trimmed.toLowerCase().split(RegExp(r'\s+')).join(' ');
  }
  return trimmed;
}

List<String> recoveryWords(String credential) => credential
    .trim()
    .toLowerCase()
    .split(RegExp(r'\s+'))
    .where((word) => word.isNotEmpty)
    .toList(growable: false);
