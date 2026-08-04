import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/vault_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkVaultStatus();
  }

  Future<void> _checkVaultStatus() async {
    // Adding slight delay for splash visibility
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    try {
      final lifecycle = ref.read(vaultLifecycleProvider);
      final exists = await lifecycle.exists();
      if (!mounted) return;
      if (exists) {
        // Vault exists, navigate to unlock screen (38_lock_screen)
        context.go('/lock');
      } else {
        // First time setup
        context.go('/welcome');
      }
    } catch (e) {
      if (mounted) context.go('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Uses bgPrimary from AppTheme
      body: Center(
        child: Image.asset('assets/splash_icon.png', width: 240, fit: BoxFit.contain),
      ),
    );
  }
}
