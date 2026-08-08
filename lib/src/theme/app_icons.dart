import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const String _path = 'assets/icons/colored';

  static Widget appShield({double? width, double? height}) => SvgPicture.asset(
    '$_path/app_shield_badge.svg',
    width: width,
    height: height,
  );

  static Widget offlineWifi({double? width, double? height}) =>
      SvgPicture.asset('$_path/offline_wifi.svg', width: width, height: height);

  static Widget encryptedLock({double? width, double? height}) =>
      SvgPicture.asset(
        '$_path/encrypted_lock.svg',
        width: width,
        height: height,
      );

  static Widget privacyHeart({double? width, double? height}) =>
      SvgPicture.asset(
        '$_path/privacy_heart.svg',
        width: width,
        height: height,
      );

  static Widget privacyShield({double? width, double? height}) =>
      SvgPicture.asset(
        '$_path/total_privacy_shield.svg',
        width: width,
        height: height,
      );

  static Widget localAi({double? width, double? height}) =>
      SvgPicture.asset('$_path/local_ai.svg', width: width, height: height);

  static Widget zeroKnowledgeLock({double? width, double? height}) =>
      SvgPicture.asset(
        '$_path/zero_knowledge_lock.svg',
        width: width,
        height: height,
      );

  static Widget vaultLock({double? width, double? height}) =>
      SvgPicture.asset('$_path/vault_lock.svg', width: width, height: height);

  static Widget keypadBackspace({double? width, double? height}) =>
      SvgPicture.asset(
        '$_path/keypad_backspace.svg',
        width: width,
        height: height,
      );

  static Widget recoveryPhrase({double? width, double? height}) =>
      SvgPicture.asset(
        '$_path/recovery_phrase.svg',
        width: width,
        height: height,
      );

  static Widget verifyPhrase({double? width, double? height}) =>
      SvgPicture.asset(
        '$_path/verify_phrase.svg',
        width: width,
        height: height,
      );
}
