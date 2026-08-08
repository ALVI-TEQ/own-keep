import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/domain/recovery/recovery_method.dart';
import 'package:vault_crypto/vault_crypto.dart';

void main() {
  test(
    'generated recovery phrase contains 12 ordered dictionary words',
    () async {
      final phrase = await RecoveryPhraseGenerator(
        _SequentialRandom(),
      ).generate();
      final words = recoveryWords(phrase);

      expect(words, hasLength(12));
      expect(words, RecoveryPhraseGenerator.words.take(12));
      expect(RecoveryPhraseGenerator.words, hasLength(256));
      expect(RecoveryPhraseGenerator.words.toSet(), hasLength(256));
    },
  );

  test('generated phrases normalize whitespace and case', () {
    expect(
      normalizeRecoveryCredential(
        '  Ocean   RIVER\nAmber  ',
        RecoveryMethod.generatedPhrase,
      ),
      'ocean river amber',
    );
  });

  test('custom recovery passwords require at least 16 characters', () {
    expect(
      'twelve chars!'.runes.length,
      lessThan(minimumNewCustomRecoveryCharacters),
    );
    const strong = 'four calm words are memorable';
    expect(
      strong.runes.length,
      greaterThanOrEqualTo(minimumNewCustomRecoveryCharacters),
    );
    expect(RecoveryCredentialPolicy.assess(strong).accepted, isTrue);
  });
}

final class _SequentialRandom implements CryptographicRandom {
  @override
  Future<Uint8List> secureBytes(int length) => Future.value(
    Uint8List.fromList(List<int>.generate(length, (index) => index)),
  );
}
