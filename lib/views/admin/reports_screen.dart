import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildStatsGrid(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6A5AE0),
            Color(0xFF8E7BFF),
            Color(0xFFE6E1FF),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                'Reports',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 8),
         
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    const cards = [
      _ReportStat(
        title: 'Revenue (Mo)',
        value: '145.2k SAR',
        icon: Icons.trending_up_rounded,
        color: Color(0xFF22C55E),
      ),
      _ReportStat(
        title: 'Net Profit',
        value: '24.5k SAR',
        icon: Icons.account_balance_wallet_rounded,
        color: Color(0xFF0EA5E9),
      ),
      _ReportStat(
        title: 'Loss / Refunds',
        value: '1.25k SAR',
        icon: Icons.trending_down_rounded,
        color: Color(0xFFEF4444),
      ),
      _ReportStat(
      title: 'Total Orders',
      value: '1240',
      icon: Icons.shopping_bag_outlined,
      color: Color(0xFF6A5AE0),
    ),
  ];
    

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useTwoColumns = constraints.maxWidth > 360;
        final crossAxisCount = useTwoColumns ? 2 : 1;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: useTwoColumns ? 1.5 : 3.2,
          children: [
            for (final stat in cards) _ReportCard(stat: stat),
          ],
        );
      },
    );
  }
}

class _ReportStat {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _ReportStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class _ReportCard extends StatelessWidget {
  final _ReportStat stat;

  const _ReportCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF7A7A8C),
        );
    final valueStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: const Color(0xFF1F1F33),
          fontWeight: FontWeight.w700,
        );

    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: stat.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                stat.icon,
                color: stat.color,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stat.title,
                    style: titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stat.value,
                    style: valueStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

