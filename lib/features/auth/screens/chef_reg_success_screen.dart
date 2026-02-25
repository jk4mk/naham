import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_design_system.dart';
import '../../../core/theme/naham_theme.dart';
import 'cook_auth_screen.dart';
import 'role_selection_screen.dart';

/// Submission success: your application is under review, we'll email you.
class ChefRegSuccessScreen extends ConsumerWidget {
  const ChefRegSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDesignSystem.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 80,
                color: NahamTheme.primary,
              ),
              const SizedBox(height: AppDesignSystem.space24),
              Text(
                'Application submitted',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: NahamTheme.textOnLight,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDesignSystem.space16),
              Text(
                'Your application is under review. We\'ll email you once you\'re approved.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppDesignSystem.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDesignSystem.space48),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                      (r) => false,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CookAuthScreen()),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    backgroundColor: NahamTheme.primary,
                    foregroundColor: NahamTheme.textOnPurple,
                  ),
                  child: const Text('Back to Cook Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
