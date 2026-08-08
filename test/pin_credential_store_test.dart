import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/citizen_vault/vault/pin_credential_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vault_crypto/vault_crypto.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  test('enrolls and recovers a credential only with the correct PIN', () async {
    final store = EncryptedPreferencesPinCredentialStore(random: _FakeRandom());
    const credential = 'ABCD-EFGH-JKLM-NPQR-STUV-WXYZ-2345-6789';

    expect(await store.isEnrolled(), isFalse);
    await store.enroll(pin: '246810', recoveryCredential: credential);

    expect(await store.isEnrolled(), isTrue);
    expect(await store.recover('246810'), credential);
    await expectLater(
      store.recover('111111'),
      throwsA(
        isA<PinCredentialFailure>().having(
          (failure) => failure.code,
          'code',
          'incorrect_pin',
        ),
      ),
    );
  });

  test('rejects malformed PINs and clears enrollment', () async {
    final store = EncryptedPreferencesPinCredentialStore(random: _FakeRandom());
    const credential = 'ABCD-EFGH-JKLM-NPQR-STUV-WXYZ-2345-6789';

    await expectLater(
      store.enroll(pin: '1234', recoveryCredential: credential),
      throwsA(isA<PinCredentialFailure>()),
    );
    await store.enroll(pin: '246810', recoveryCredential: credential);
    await store.clear();

    expect(await store.isEnrolled(), isFalse);
    await expectLater(
      store.recover('246810'),
      throwsA(
        isA<PinCredentialFailure>().having(
          (failure) => failure.code,
          'code',
          'pin_not_enrolled',
        ),
      ),
    );
  });
}

final class _FakeRandom implements CryptographicRandom {
  var _next = 1;

  @override
  Future<Uint8List> secureBytes(int length) async =>
      Uint8List.fromList(List<int>.generate(length, (_) => (_next++) & 0xff));
}
