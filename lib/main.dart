import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'package:ownkeep/src/citizen_vault/vault/vault_lifecycle.dart';

import 'src/routing/app_router.dart';
import 'src/theme/app_theme.dart';
import 'src/providers/vault_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final lifecycle = await LocalVaultLifecycle.applicationSupport();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('app_dark_mode') ?? true;
  final themeColor = prefs.getString('app_theme_color') ?? 'blue';

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
    if (state == AppLifecycleState.resumed) {
      _lockTimer?.cancel();
      return;
    }
    if (state != AppLifecycleState.paused && state != AppLifecycleState.hidden)
      return;
    _lockTimer?.cancel();
    SharedPreferences.getInstance().then((prefs) {
      if (!mounted) return;
      final index = prefs.getInt('app_auto_lock_index') ?? 0;
      final delay = switch (index) {
        1 => const Duration(seconds: 30),
        2 => const Duration(minutes: 2),
        _ => Duration.zero,
      };
      _lockTimer = Timer(delay, () async {
        if (!mounted || ref.read(vaultSessionProvider).value == null) {
          return;
        }
        await ref.read(vaultSessionProvider.notifier).lockVault();
        if (mounted) ref.read(goRouterProvider).go('/lock');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final isDarkMode = ref.watch(appDarkModeProvider);
    final themeColor = ref.watch(appThemeColorProvider);

    OwnKeepColors.applyTheme(themeColor);

    return MaterialApp.router(
      title: 'OwnKeep',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
