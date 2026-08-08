import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ownkeep/src/citizen_vault/vault/user_agreement_screen.dart';
import 'package:ownkeep/src/presentation/legal/ownkeep_legal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('current agreement must be accepted before vault creation', () async {
    expect(await OwnKeepUserAgreement.hasCurrentAcceptance(), isFalse);
    await OwnKeepUserAgreement.recordAcceptance();
    expect(await OwnKeepUserAgreement.hasCurrentAcceptance(), isTrue);
    final preferences = await SharedPreferences.getInstance();
    expect(
      preferences.getString(OwnKeepUserAgreement.receiptVersionKey),
      OwnKeepLegal.agreementVersion,
    );
    expect(
      preferences.getString(OwnKeepUserAgreement.receiptAcceptedAtKey),
      isNotEmpty,
    );
  });

  test('Play-facing legal endpoints are stable public HTTPS URLs', () {
    expect(
      OwnKeepLegal.privacyUrl,
      'https://alviteq.com/products/ownkeep/privacy',
    );
    expect(OwnKeepLegal.termsUrl, 'https://alviteq.com/products/ownkeep/terms');
    expect(Uri.parse(OwnKeepLegal.privacyUrl).hasAbsolutePath, isTrue);
    expect(Uri.parse(OwnKeepLegal.termsUrl).scheme, 'https');
  });
}
