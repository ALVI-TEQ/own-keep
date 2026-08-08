/// Process-wide guard for trusted platform UI launched by OwnKeep.
///
/// Camera, document providers, biometric prompts and system share/save sheets
/// pause the Flutter activity even though the user has not left the workflow.
/// The lock observers consult this guard before closing the encrypted vault.
abstract final class TrustedExternalActivity {
  static var _activeCount = 0;

  static bool get isActive => _activeCount > 0;

  static void begin() => _activeCount += 1;

  static void end() {
    if (_activeCount > 0) _activeCount -= 1;
  }

  static Future<T> run<T>(Future<T> Function() action) async {
    begin();
    try {
      return await action();
    } finally {
      end();
    }
  }
}
