import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vault_crypto/vault_crypto.dart';
import 'package:vault_platform/vault_platform.dart';

/// Stores the recovery credential encrypted by the user's local six-digit PIN.
///
/// The recovery credential is never written as plaintext. The intentionally
/// expensive KDF slows offline PIN guessing; UI retry throttling provides the
/// online protection.
abstract interface class PinCredentialStore {
  Future<bool> isEnrolled();
  Future<void> enroll({
    required String pin,
    required String recoveryCredential,
  });
  Future<String> recover(String pin);
  Future<void> clear();
}

final class EncryptedPreferencesPinCredentialStore
    implements PinCredentialStore {
  EncryptedPreferencesPinCredentialStore({
    this._random = const PlatformCryptographicRandom(),
  });

  final CryptographicRandom _random;

  static const _storageKey = 'ownkeep.pin_credential.v1';
  static const _aad = <int>[
    111,
    119,
    110,
    107,
    101,
    101,
    112,
    45,
    112,
    105,
    110,
    45,
    118,
    49,
  ];
  static final _pinPattern = RegExp(r'^\d{6}$');
  static final _kdf = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 600000,
    bits: 256,
  );
  static final _cipher = AesGcm.with256bits();

  @override
  Future<bool> isEnrolled() async =>
      (await SharedPreferences.getInstance()).containsKey(_storageKey);

  @override
  Future<void> enroll({
    required String pin,
    required String recoveryCredential,
  }) async {
    _validatePin(pin);
    if (!RecoveryCredentialPolicy.assess(recoveryCredential).accepted) {
      throw const PinCredentialFailure('invalid_recovery_credential');
    }
    final salt = await _random.secureBytes(32);
    final nonce = await _random.secureBytes(12);
    final key = await _deriveKey(pin, salt);
    final plaintext = Uint8List.fromList(utf8.encode(recoveryCredential));
    try {
      final box = await _cipher.encrypt(
        plaintext,
        secretKey: key,
        nonce: nonce,
        aad: _aad,
      );
      final encoded = jsonEncode(<String, Object>{
        'version': 1,
        'salt': base64Encode(salt),
        'nonce': base64Encode(box.nonce),
        'ciphertext': base64Encode(box.cipherText),
        'mac': base64Encode(box.mac.bytes),
      });
      final saved = await (await SharedPreferences.getInstance()).setString(
        _storageKey,
        encoded,
      );
      if (!saved) throw const PinCredentialFailure('pin_storage_failed');
    } finally {
      plaintext.fillRange(0, plaintext.length, 0);
      salt.fillRange(0, salt.length, 0);
      nonce.fillRange(0, nonce.length, 0);
    }
  }

  @override
  Future<String> recover(String pin) async {
    _validatePin(pin);
    final value = (await SharedPreferences.getInstance()).getString(
      _storageKey,
    );
    if (value == null) throw const PinCredentialFailure('pin_not_enrolled');
    try {
      final json = jsonDecode(value) as Map<String, dynamic>;
      if (json['version'] != 1) throw const FormatException('version');
      final salt = base64Decode(json['salt'] as String);
      final key = await _deriveKey(pin, salt);
      final cleartext = await _cipher.decrypt(
        SecretBox(
          base64Decode(json['ciphertext'] as String),
          nonce: base64Decode(json['nonce'] as String),
          mac: Mac(base64Decode(json['mac'] as String)),
        ),
        secretKey: key,
        aad: _aad,
      );
      try {
        return utf8.decode(cleartext);
      } finally {
        cleartext.fillRange(0, cleartext.length, 0);
        salt.fillRange(0, salt.length, 0);
      }
    } on PinCredentialFailure {
      rethrow;
    } on Object catch (error) {
      throw PinCredentialFailure('incorrect_pin', cause: error);
    }
  }

  @override
  Future<void> clear() async {
    await (await SharedPreferences.getInstance()).remove(_storageKey);
  }

  Future<SecretKey> _deriveKey(String pin, List<int> salt) => _kdf.deriveKey(
    secretKey: SecretKey(utf8.encode('ownkeep-local-pin-v1:$pin')),
    nonce: salt,
  );

  static void _validatePin(String pin) {
    if (!_pinPattern.hasMatch(pin)) {
      throw const PinCredentialFailure('invalid_pin');
    }
  }
}

final class PinCredentialFailure implements Exception {
  const PinCredentialFailure(this.code, {this.cause});
  final String code;
  final Object? cause;
}
