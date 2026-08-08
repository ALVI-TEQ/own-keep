import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'package:ownkeep/src/citizen_vault/vault/vault_lifecycle.dart';

import 'src/routing/app_router.dart';
import 'src/theme/app_theme.dart';
import 'src/providers/vault_provider.dart';
import 'src/providers/subscription_provider.dart';
import 'src/domain/subscription/feature_entitlements.dart';
import 'src/platform/trusted_external_activity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final lifecycle = await LocalVaultLifecycle.applicationSupport();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('app_dark_mode') ?? true;
  final themeColor = prefs.getString('app_theme_color') ?? 'blue';
  final languageCode = prefs.getString('ownkeep_ui_language') ?? 'en';
  final initialPlan = prefs.getBool('ownkeep_test_pro_entitlement') == true
      ? OwnKeepPlan.pro
      : OwnKeepPlan.free;

  runApp(
    ProviderScope(
      overrides: [
        vaultLifecycleProvider.overrideWithValue(lifecycle),
        appDarkModeProvider.overrideWith(
          () => AppDarkModeNotifier(initialValue: isDark),
        ),
        appThemeColorProvider.overrideWith(
          () => AppThemeColorNotifier(initialValue: themeColor),
        ),
        appLanguageProvider.overrideWith(
          () => AppLanguageNotifier(initialValue: languageCode),
        ),
        ownKeepPlanProvider.overrideWith(
          () => OwnKeepPlanNotifier(initialPlan: initialPlan),
        ),
      ],
      child: const OwnKeepApp(),
    ),
  );
}

class OwnKeepApp extends ConsumerStatefulWidget {
  const OwnKeepApp({super.key});

  @override
  ConsumerState<OwnKeepApp> createState() => _OwnKeepAppState();
}

class _OwnKeepAppState extends ConsumerState<OwnKeepApp>
    with WidgetsBindingObserver {
  Timer? _lockTimer;
  AppLifecycleState _lifecycleState = AppLifecycleState.resumed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lockTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lifecycleState = state;
    if (state == AppLifecycleState.resumed) {
      _lockTimer?.cancel();
      return;
    }
    if (state != AppLifecycleState.paused &&
        state != AppLifecycleState.hidden) {
      return;
    }
    _lockTimer?.cancel();
    SharedPreferences.getInstance().then((prefs) {
      if (!mounted ||
          (_lifecycleState != AppLifecycleState.paused &&
              _lifecycleState != AppLifecycleState.hidden)) {
        return;
      }
      final index = prefs.getInt('app_auto_lock_index') ?? 0;
      final delay = switch (index) {
        1 => const Duration(seconds: 30),
        2 => const Duration(minutes: 2),
        _ => Duration.zero,
      };
      _lockTimer = Timer(delay, () async {
        final handle = ref.read(vaultSessionProvider).value;
        if (!mounted ||
            handle == null ||
            handle.isBusy ||
            TrustedExternalActivity.isActive) {
          return;
        }
        final router = ref.read(goRouterProvider);
        final returnTo = router.routerDelegate.currentConfiguration.uri
            .toString();
        await ref.read(vaultSessionProvider.notifier).lockVault();
        if (mounted) {
          router.go(
            Uri(
              path: '/lock',
              queryParameters: {'returnTo': returnTo},
            ).toString(),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final isDarkMode = ref.watch(appDarkModeProvider);
    final themeColor = ref.watch(appThemeColorProvider);
    final languageCode = ref.watch(appLanguageProvider);

    OwnKeepColors.applyTheme(themeColor);

    return MaterialApp.router(
      title: 'OwnKeep',
      themeAnimationDuration: Duration.zero,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(languageCode),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
