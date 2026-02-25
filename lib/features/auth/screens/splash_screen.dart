import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/naham_theme.dart';
import '../../customer/naham_customer_screens.dart';
import '../../cook/screens/cook_main_navigation_screen.dart';
import 'cook_pending_screen.dart';
import 'role_selection_screen.dart';
import '../presentation/providers/auth_provider.dart';

/// Splash: purple background, logo + "Naham". After 2–3 seconds, navigate by login status (SharedPreferences).
/// Logged in → Customer Home / Cook Home / Cook Pending. Else → Role Selection.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateAfterDelay());
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;
    final user = ref.read(authStateProvider).valueOrNull;
    if (user != null) {
      if (user.isCustomer) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
        );
        return;
      }
      if (user.isChefApproved) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const CookMainNavigationScreen()),
        );
        return;
      }
      if (user.isChefPending) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const CookPendingScreen()),
        );
        return;
      }
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: NahamTheme.primary,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    NahamTheme.logoAsset,
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_rounded, size: 64, color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Naham',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Home food, made with love',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.95),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
