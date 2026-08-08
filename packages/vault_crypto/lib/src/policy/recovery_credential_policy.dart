import 'dart:convert';

import 'package:vault_crypto/src/errors/crypto_failure.dart';
import 'package:vault_crypto/src/random/cryptographic_random.dart';

/// Result of local recovery credential validation.
final class RecoveryCredentialAssessment {
  /// Creates an assessment.
  const RecoveryCredentialAssessment({
    required this.accepted,
    required this.score,
    required this.reason,
  });

  /// Whether onboarding may continue.
  final bool accepted;

  /// Coarse local score from zero to four.
  final int score;

  /// Stable safe reason code.
  final String reason;
}

/// Length-based recovery policy without arbitrary character-class rules.
abstract final class RecoveryCredentialPolicy {
  /// Minimum user-chosen passphrase length.
  static const int minimumCharacters = 12;

  /// Maximum UTF-8 bytes accepted to bound KDF input handling.
  static const int maximumUtf8Bytes = 1024;

  static const Set<String> _commonPasswords = <String>{
    'password',
    'password123',
    '123456789012',
    'qwertyuiop12',
    'letmein123456',
  };

  /// Assesses a passphrase locally without logging or retaining it.
  static RecoveryCredentialAssessment assess(String passphrase) {
    final byteLength = utf8.encode(passphrase).length;
    if (byteLength > maximumUtf8Bytes) {
      return const RecoveryCredentialAssessment(
        accepted: false,
        score: 0,
        reason: 'too_long',
      );
    }
    if (_commonPasswords.contains(passphrase.toLowerCase())) {
      return const RecoveryCredentialAssessment(
        accepted: false,
        score: 0,
        reason: 'common_password',
      );
    }
    if (passphrase.runes.length < minimumCharacters) {
      return const RecoveryCredentialAssessment(
        accepted: false,
        score: 0,
        reason: 'too_short',
      );
    }
    final length = passphrase.runes.length;
    final score = switch (length) {
      >= 32 => 4,
      >= 24 => 3,
      >= 16 => 2,
      _ => 1,
    };
    return RecoveryCredentialAssessment(
      accepted: true,
      score: score,
      reason: 'accepted',
    );
  }
}

/// Generates a 12-word, 96-bit recovery phrase from an embedded offline list.
///
/// Each random byte selects one of 256 distinct words. The phrase is intended
/// for OwnKeep recovery and is not presented as a BIP-39 cryptocurrency seed.
final class RecoveryPhraseGenerator {
  const RecoveryPhraseGenerator(this._random);

  final CryptographicRandom _random;

  static const int wordCount = 12;
  static const List<String> words = <String>[
    'acorn',
    'amber',
    'anchor',
    'apple',
    'april',
    'arch',
    'arrow',
    'atlas',
    'autumn',
    'badge',
    'bamboo',
    'beach',
    'beacon',
    'berry',
    'birch',
    'bird',
    'bloom',
    'blue',
    'boat',
    'book',
    'breeze',
    'brick',
    'bridge',
    'brook',
    'brush',
    'cabin',
    'cactus',
    'candle',
    'canyon',
    'cedar',
    'cherry',
    'circle',
    'clay',
    'cliff',
    'cloud',
    'clover',
    'coast',
    'cobalt',
    'comet',
    'coral',
    'cosmos',
    'crane',
    'creek',
    'crystal',
    'dawn',
    'delta',
    'desert',
    'dew',
    'drift',
    'dune',
    'eagle',
    'earth',
    'echo',
    'elm',
    'ember',
    'falcon',
    'farm',
    'feather',
    'fern',
    'field',
    'finch',
    'fjord',
    'flame',
    'flora',
    'forest',
    'fossil',
    'fox',
    'frost',
    'garden',
    'gem',
    'glade',
    'glass',
    'globe',
    'gold',
    'granite',
    'grape',
    'grass',
    'green',
    'grove',
    'harbor',
    'hawk',
    'hazel',
    'hill',
    'honey',
    'horizon',
    'ice',
    'indigo',
    'iris',
    'island',
    'ivory',
    'jade',
    'jasmine',
    'juniper',
    'kite',
    'lake',
    'lantern',
    'leaf',
    'lemon',
    'lilac',
    'lily',
    'lotus',
    'lunar',
    'maple',
    'marble',
    'meadow',
    'mesa',
    'meteor',
    'mint',
    'moon',
    'moss',
    'mountain',
    'navy',
    'nectar',
    'nest',
    'north',
    'oak',
    'oasis',
    'ocean',
    'olive',
    'onyx',
    'opal',
    'orange',
    'orchid',
    'otter',
    'owl',
    'palm',
    'paper',
    'pearl',
    'pebble',
    'pine',
    'planet',
    'plum',
    'pond',
    'prairie',
    'quartz',
    'rain',
    'raven',
    'reef',
    'ridge',
    'river',
    'robin',
    'rose',
    'ruby',
    'sage',
    'sand',
    'scarlet',
    'sea',
    'shell',
    'shore',
    'silver',
    'sky',
    'slate',
    'snow',
    'solar',
    'south',
    'sparrow',
    'spring',
    'spruce',
    'star',
    'stone',
    'storm',
    'summit',
    'sun',
    'surf',
    'swift',
    'teal',
    'thistle',
    'thunder',
    'tide',
    'timber',
    'topaz',
    'trail',
    'tree',
    'tulip',
    'valley',
    'violet',
    'wave',
    'west',
    'willow',
    'wind',
    'winter',
    'wood',
    'wren',
    'yellow',
    'zephyr',
    'alder',
    'alpine',
    'bay',
    'blossom',
    'branch',
    'bronze',
    'cape',
    'cascade',
    'cave',
    'celadon',
    'cinder',
    'copper',
    'cove',
    'dahlia',
    'daisy',
    'dream',
    'east',
    'evergreen',
    'fawn',
    'fire',
    'flower',
    'fog',
    'glacier',
    'harvest',
    'heather',
    'heron',
    'isle',
    'lagoon',
    'laurel',
    'light',
    'linen',
    'magnolia',
    'marine',
    'mist',
    'morning',
    'orchard',
    'peak',
    'petal',
    'rainbow',
    'redwood',
    'rock',
    'saffron',
    'shadow',
    'sierra',
    'silk',
    'sprout',
    'steel',
    'sunset',
    'terra',
    'thorn',
    'vale',
    'water',
    'wild',
    'wing',
    'woodland',
    'azure',
    'basil',
    'canopy',
    'citron',
    'cypress',
    'garnet',
    'ginger',
    'glen',
    'indian',
    'larch',
    'mango',
    'marigold',
    'mercury',
    'peach',
    'pinecone',
    'reed',
  ];

  Future<String> generate() async {
    final bytes = await _random.secureBytes(wordCount);
    if (bytes.length != wordCount) {
      throw const EntropyUnavailableFailure();
    }
    return bytes.map((value) => words[value]).join(' ');
  }
}

/// Generates a high-entropy, human-transcribable recovery code.
final class RecoveryCodeGenerator {
  /// Creates a generator using an OS-backed random source.
  const RecoveryCodeGenerator(this._random);

  final CryptographicRandom _random;

  static const String _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  /// Generates 32 unbiased symbols grouped for transcription.
  Future<String> generate() async {
    final List<int> bytes;
    try {
      bytes = await _random.secureBytes(32);
      if (bytes.length != 32) {
        throw const EntropyUnavailableFailure();
      }
    } on VaultCryptoFailure {
      rethrow;
    } on Object catch (error) {
      throw EntropyUnavailableFailure(cause: error);
    }
    final symbols = StringBuffer();
    for (var index = 0; index < bytes.length; index += 1) {
      if (index > 0 && index.isEven && index % 4 == 0) {
        symbols.write('-');
      }
      symbols.write(_alphabet[bytes[index] & 31]);
    }
    return symbols.toString();
  }
}
