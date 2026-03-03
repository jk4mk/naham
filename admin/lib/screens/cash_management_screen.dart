import 'package:flutter/material.dart';

import '../core/theme/app_design_system.dart';
import '../core/widgets/naham_screen_header.dart';

class CashManagementScreen extends StatelessWidget {
  const CashManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: NahamScreenHeader(title: 'Cash & Payments')),
          SliverPadding(
            padding: const EdgeInsets.all(AppDesignSystem.space24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDesignSystem.space24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payments Awaiting Approval',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _PaymentRow(
                          label: 'Withdrawal from Chef Ahmed - SAR 500',
                          date: '2025-03-01',
                          onApprove: () {},
                          onReject: () {},
                        ),
                        const Divider(),
                        _PaymentRow(
                          label: 'Withdrawal from Chef Fatima - SAR 1,200',
                          date: '2025-02-28',
                          onApprove: () {},
                          onReject: () {},
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Refresh'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDesignSystem.space24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Summary",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Sales', style: Theme.of(context).textTheme.bodyLarge),
                            Text('SAR 3,450', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppDesignSystem.successGreen)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pending Commissions', style: Theme.of(context).textTheme.bodyLarge),
                            Text('SAR 345', style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final String date;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _PaymentRow({
    required this.label,
    required this.date,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.titleSmall),
                Text(date, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.check_circle_rounded),
            color: AppDesignSystem.successGreen,
            onPressed: onApprove,
          ),
          IconButton(
            icon: const Icon(Icons.cancel_rounded),
            color: AppDesignSystem.errorRed,
            onPressed: onReject,
          ),
        ],
      ),
    );
  }
}
