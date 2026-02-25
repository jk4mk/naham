import 'package:flutter/material.dart';

import '../../../core/theme/naham_theme.dart';
import 'cook_auth_screen.dart';
import 'role_selection_screen.dart';

/// Shown when cook has logged in but application is still pending approval.
/// No back to home; user can go back to Cook Login or Role Selection.
class CookPendingScreen extends StatelessWidget {
  const CookPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 80,
                color: NahamTheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Pending approval',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: NahamTheme.textOnLight,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your application is under review. We\'ll email you once you\'re approved.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: NahamTheme.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
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
