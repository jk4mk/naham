import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_design_system.dart';
import '../../../core/constants/route_names.dart';

/// Step 2: Upload documents for chef registration.
class ChefRegDocumentsScreen extends ConsumerWidget {
  const ChefRegDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundOffWhite,
      appBar: AppBar(
        title: const Text('Chef registration'),
        backgroundColor: AppDesignSystem.backgroundOffWhite,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDesignSystem.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Upload documents',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Step 2 of 2. We need these to verify your kitchen.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppDesignSystem.textSecondary,
                    ),
              ),
              const SizedBox(height: 24),
              _DocumentCard(
                title: 'Upload ID',
                onTap: () {},
              ),
              const SizedBox(height: AppDesignSystem.space16),
              _DocumentCard(
                title: 'Upload Health Certificate',
                onTap: () {},
              ),
              const SizedBox(height: AppDesignSystem.space16),
              _DocumentCard(
                title: 'Upload Kitchen License (optional)',
                onTap: () {},
              ),
              const SizedBox(height: AppDesignSystem.space32),
              FilledButton(
                onPressed: () => context.go(RouteNames.chefRegSuccess),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: AppDesignSystem.primaryGreen,
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DocumentCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.upload_file),
        title: Text(title),
        trailing: const Icon(Icons.add_circle_outline),
        onTap: onTap,
      ),
    );
  }
}
