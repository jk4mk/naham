// ============================================================
// COOK EARNINGS & INSIGHTS — Naham App
// Premium green design system
// ============================================================

import 'package:flutter/material.dart';

// ─── Colors ──────────────────────────────────────────────────
class _NC {
  static const primary = Color(0xFF4A2990);
  static const primaryMid = Color(0xFF6C3FC5);
  static const primaryBright = Color(0xFF7C4FD5);
  static const primaryLight = Color(0xFFF0EBFF);
  static const primaryGlow = Color(0x306C3FC5);
  static const bg = Color(0xFFF5F0FF);
  static const surface = Color(0xFFFFFFFF);
  static const text = Color(0xFF1A0F2E);
  static const textSub = Color(0xFF6B5B95);
  static const border = Color(0xFFE8E0F5);
  static const error = Color(0xFFD93025);
  static const gold = Color(0xFFD97706);
  static const info = Color(0xFF0EA5E9);
}

// ══════════════════════════════════════════════════════════════
// EARNINGS SCREEN
// ══════════════════════════════════════════════════════════════
class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  final _weeklyData = const [
    400.0,
    520.0,
    480.0,
    600.0,
    650.0,
    680.0,
    590.0
  ];
  final _days = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _NC.bg,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          _buildPayoutCards(),
          _buildStatsGrid(),
          _buildWeeklyChart(),
          _buildBestSellers(),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [_NC.primary, _NC.primaryMid, _NC.primaryBright],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 24),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white)),
                const Expanded(
                    child: Text('Earnings & Insights',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white))),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text('Jan 2026',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPayoutCards() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _PayoutCard(
              icon: Icons.check_circle_rounded,
              iconColor: _NC.primaryMid,
              iconBg: _NC.primaryLight,
              title: 'Last Payout',
              amount: '824.00',
              subtitle: 'Dec 10, 2025',
              accentColor: _NC.primaryMid,
            ),
            const SizedBox(height: 12),
            _PayoutCard(
              icon: Icons.calendar_today_rounded,
              iconColor: const Color(0xFF7C3AED),
              iconBg: const Color(0xFFF5F3FF),
              title: 'Next Payout',
              amount: '430.00~',
              subtitle: 'Jan 24, 2026 (estimated)',
              accentColor: const Color(0xFF7C3AED),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _NC.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _NC.border),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 12,
                      offset: Offset(0, 4))
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            'Earnings Since Last Payout',
                            style: TextStyle(
                                fontSize: 13,
                                color: _NC.textSub)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text('SAR ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _NC.text)),
                            const Text('580.00',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: _NC.text)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: _NC.primaryLight,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.trending_up_rounded,
                        color: _NC.primaryMid, size: 28),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Performance',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _NC.text)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                _GridStat('142', 'Total Orders',
                    Icons.receipt_long_rounded, _NC.primaryMid, _NC.primaryLight),
                _GridStat('4.9 ⭐', 'Avg Rating', Icons.star_rounded,
                    _NC.gold, const Color(0xFFFFFBEB)),
                _GridStat('68%', 'Repeat Customers', Icons.people_rounded,
                    _NC.info, const Color(0xFFEFF6FF)),
                _GridStat('32 min', 'Avg Prep Time', Icons.timer_rounded,
                    const Color(0xFF7C3AED), const Color(0xFFF5F3FF)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _NC.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _NC.border),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08000000),
                blurRadius: 12,
                offset: Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: _NC.primaryLight,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.bar_chart_rounded,
                      color: _NC.primaryMid, size: 20),
                ),
                const SizedBox(width: 12),
                const Text('Weekly Revenue',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _NC.text)),
                const Spacer(),
                const Text('This Week',
                    style: TextStyle(
                        fontSize: 12,
                        color: _NC.textSub)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 140,
                child: _SimpleLineChart(
                    data: _weeklyData, days: _days)),
          ],
        ),
      ),
    );
  }

  Widget _buildBestSellers() {
    final dishes = [
      {
        'name': 'Chicken Kabsa',
        'orders': 42,
        'revenue': 1890.0,
        'emoji': '🍛'
      },
      {'name': 'Margog', 'orders': 35, 'revenue': 1925.0, 'emoji': '🥘'},
      {'name': 'Kunafa', 'orders': 28, 'revenue': 700.0, 'emoji': '🍮'},
    ];
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Best Sellers',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _NC.text)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: _NC.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _NC.border),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 12,
                      offset: Offset(0, 4))
                ],
              ),
              child: Column(
                children: dishes.asMap().entries.map((e) {
                  final i = e.key;
                  final d = e.value;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  color: _NC.primaryLight,
                                  borderRadius:
                                      BorderRadius.circular(12)),
                              child: Center(
                                  child: Text(d['emoji'] as String,
                                      style: const TextStyle(
                                          fontSize: 22))),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(d['name'] as String,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: _NC.text)),
                                  Text(
                                      '${d['orders']} orders',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: _NC.textSub)),
                                ],
                              ),
                            ),
                            Text(
                                '${(d['revenue'] as double).toStringAsFixed(0)} SAR',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: _NC.primaryMid)),
                            const SizedBox(width: 8),
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: i == 0
                                    ? const Color(0xFFFFFBEB)
                                    : i == 1
                                        ? const Color(0xFFF5F5F5)
                                        : const Color(0xFFFFF7ED),
                                borderRadius:
                                    BorderRadius.circular(8),
                              ),
                              child: Center(
                                  child: Text(
                                      i == 0
                                          ? '🥇'
                                          : i == 1
                                              ? '🥈'
                                              : '🥉',
                                      style: const TextStyle(
                                          fontSize: 14))),
                            ),
                          ],
                        ),
                      ),
                      if (i < dishes.length - 1)
                        Container(
                            height: 1,
                            color: _NC.border,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 14),
                          ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Earnings Helpers ─────────────────────────────────────────
class _PayoutCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Color accentColor;
  final String title;
  final String amount;
  final String subtitle;

  const _PayoutCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _NC.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _NC.border),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08000000),
                blurRadius: 12,
                offset: Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 13,
                          color: _NC.textSub)),
                  Row(
                    children: [
                      const Text('SAR ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _NC.text)),
                      Text(amount,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: accentColor)),
                    ],
                  ),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 11,
                          color: _NC.textSub)),
                ],
              ),
            ),
          ],
        ),
      );
}

class _GridStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final Color bg;

  const _GridStat(
      this.value, this.label, this.icon, this.color, this.bg);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _NC.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _NC.border),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08000000),
                blurRadius: 8,
                offset: Offset(0, 3))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: color)),
                  Text(label,
                      style: const TextStyle(
                          fontSize: 10,
                          color: _NC.textSub)),
                ],
              ),
            ),
          ],
        ),
      );
}

class _SimpleLineChart extends StatelessWidget {
  final List<double> data;
  final List<String> days;

  const _SimpleLineChart(
      {required this.data, required this.days});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(data: data, days: days),
      child: Container(),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> days;

  const _LineChartPainter(
      {required this.data, required this.days});

  @override
  void paint(Canvas canvas, Size size) {
    final max = data.reduce((a, b) => a > b ? a : b);
    final min = data.reduce((a, b) => a < b ? a : b);
    final range = max - min;
    final chartHeight = size.height - 24;
    final stepX = size.width / (data.length - 1);

    final points = data.asMap().entries.map((e) {
      final x = e.key * stepX;
      final y =
          chartHeight - ((e.value - min) / range) * chartHeight;
      return Offset(x, y);
    }).toList();

    // Fill
    final fillPath = Path();
    fillPath.moveTo(points.first.dx, chartHeight);
    for (final p in points) fillPath.lineTo(p.dx, p.dy);
    fillPath.lineTo(points.last.dx, chartHeight);
    fillPath.close();
    canvas.drawPath(
        fillPath,
        Paint()
          ..shader = LinearGradient(
                  colors: [
                    _NC.primaryMid.withOpacity(0.3),
                    _NC.primaryMid.withOpacity(0.0)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
              .createShader(Rect.fromLTWH(
                  0, 0, size.width, chartHeight)));

    // Line
    final linePaint = Paint()
      ..color = _NC.primaryMid
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(linePath, linePaint);

    // Dots + labels
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(
          points[i], 4, Paint()..color = _NC.primaryMid);
      canvas.drawCircle(
          points[i], 2.5, Paint()..color = Colors.white);
      final tp = TextPainter(
        text: TextSpan(
            text: days[i],
            style: const TextStyle(
                fontSize: 10, color: _NC.textSub)),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas,
          Offset(points[i].dx - tp.width / 2, chartHeight + 6));
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
