// ============================================================
// COOK HOME — Naham App (same theme as Customer)
// ============================================================

import 'package:flutter/material.dart';

import '../../../core/theme/app_design_system.dart';
import '../../../core/widgets/naham_app_header.dart';
import 'earnings_screen.dart';
import 'bank_account_screen.dart';

// ─── Colors (match AppDesignSystem) ───────────────────────────
class _NC {
  static const primary = AppDesignSystem.primary;
  static const primaryDark = AppDesignSystem.primaryDark;
  static const primaryLight = AppDesignSystem.primaryLight;
  static const primaryMid = AppDesignSystem.primaryMid;
  static const primaryGlow = Color(0x309B7EC8);
  static const bg = AppDesignSystem.backgroundOffWhite;
  static const surface = AppDesignSystem.cardWhite;
  static const text = AppDesignSystem.textPrimary;
  static const textSub = AppDesignSystem.textSecondary;
  static const border = Color(0xFFE8E0F5);
  static const error = Color(0xFFD93025);
  static const warning = Color(0xFFF59E0B);
  static const gold = Color(0xFFD97706);
  static const info = Color(0xFF0EA5E9);
}

// ══════════════════════════════════════════════════════════════
// HOME SCREEN
// ══════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOnline = false;
  bool _hasAlert = true;
  int _todayOrders = 5;
  double _todayEarnings = 245.0;
  double _rating = 4.9;

  final _todayHours = '4:00 PM – 10:00 PM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _NC.bg,
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          if (_hasAlert) _buildAlertBanner(),
          _buildOnlineCard(),
          _buildTodayStats(),
          _buildTodayWorkHours(),
          _buildQuickActions(),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: NahamAppHeader(
        showCart: false,
        searchHint: 'ابحث في الطلبات أو العملاء...',
        locationLabel: 'الرياض، حي الملقا',
      ),
    );
  }

  Widget _buildAlertBanner() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => setState(() => _hasAlert = false),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7ED),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _NC.warning.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _NC.warning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.warning_amber_rounded,
                    color: _NC.warning, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delayed Orders Action',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _NC.text)),
                    Text('Review required immediately',
                        style: TextStyle(fontSize: 12, color: _NC.textSub)),
                  ],
                ),
              ),
              const Icon(Icons.close_rounded, size: 18, color: _NC.textSub),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineCard() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _NC.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: _isOnline
                  ? _NC.primaryMid.withOpacity(0.3)
                  : _NC.border),
          boxShadow: [
            BoxShadow(
              color: _isOnline
                  ? _NC.primaryGlow
                  : const Color(0x08000000),
              blurRadius: _isOnline ? 16 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _isOnline
                    ? _NC.primaryLight
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.storefront_rounded,
                  color: _isOnline ? _NC.primaryMid : _NC.textSub,
                  size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Maria's Kitchen",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _NC.text)),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      _isOnline
                          ? '🟢 Online — accepting orders'
                          : '⚪ Offline',
                      key: ValueKey(_isOnline),
                      style: TextStyle(
                          fontSize: 12,
                          color: _isOnline
                              ? _NC.primaryMid
                              : _NC.textSub,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _isOnline = !_isOnline),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 52,
                height: 30,
                decoration: BoxDecoration(
                  color: _isOnline
                      ? _NC.primaryMid
                      : const Color(0xFFCCCCCC),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: _isOnline
                      ? [
                          BoxShadow(
                              color: _NC.primaryMid.withOpacity(0.4),
                              blurRadius: 8)
                        ]
                      : [],
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: _isOnline
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 26,
                    height: 26,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x30000000),
                              blurRadius: 4)
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayStats() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Row(
          children: [
            _StatCard('$_todayOrders', 'Orders Today',
                Icons.receipt_long_rounded, _NC.primaryMid, _NC.primaryLight),
            const SizedBox(width: 12),
            _StatCard(
                '${_todayEarnings.toStringAsFixed(0)}',
                'SAR Earned',
                Icons.payments_rounded,
                _NC.gold,
                const Color(0xFFFFF7ED)),
            const SizedBox(width: 12),
            _StatCard('$_rating', 'Rating', Icons.star_rounded,
                const Color(0xFFFBBF24), const Color(0xFFFFFBEB)),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayWorkHours() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: _NC.primaryLight,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.schedule_rounded,
                      color: _NC.primaryMid, size: 18),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Today's Hours",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _NC.text)),
                      Text('Monday',
                          style: TextStyle(
                              fontSize: 12, color: _NC.textSub)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showEditHoursSheet(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _NC.primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Edit Today',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _NC.primaryMid)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: _NC.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time_rounded,
                      size: 16, color: _NC.primaryMid),
                  const SizedBox(width: 8),
                  Text(_todayHours,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _NC.primaryMid)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: _NC.primaryMid,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Text('Today',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _NC.primaryMid,
                      side: const BorderSide(color: _NC.border),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Extend +2h',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _NC.primaryMid,
                      side: const BorderSide(color: _NC.border),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Tonight Only',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quick Actions',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _NC.text)),
            const SizedBox(height: 12),
            Row(
              children: [
                _QuickAction(
                    icon: Icons.add_circle_rounded,
                    label: 'Add Dish',
                    color: _NC.primaryMid,
                    bg: _NC.primaryLight,
                    onTap: () {}),
                const SizedBox(width: 12),
                _QuickAction(
                    icon: Icons.play_circle_rounded,
                    label: 'Post Reel',
                    color: const Color(0xFF7C3AED),
                    bg: const Color(0xFFF5F3FF),
                    onTap: () {}),
                const SizedBox(width: 12),
                _QuickAction(
                    icon: Icons.bar_chart_rounded,
                    label: 'Earnings',
                    color: _NC.gold,
                    bg: const Color(0xFFFFF7ED),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const EarningsScreen()))),
                const SizedBox(width: 12),
                _QuickAction(
                    icon: Icons.account_balance_rounded,
                    label: 'Bank',
                    color: _NC.info,
                    bg: const Color(0xFFEFF6FF),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const BankAccountScreen()))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditHoursSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        margin: const EdgeInsets.only(top: 60),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(28))),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: _NC.border,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Edit Today's Hours",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _NC.text)),
              const SizedBox(height: 4),
              const Text(
                'Monday only — does not affect weekly schedule',
                style: TextStyle(fontSize: 13, color: _NC.textSub),
              ),
              const SizedBox(height: 24),
              _TimeRow(label: 'Start Time', time: '4:00 PM'),
              const SizedBox(height: 12),
              _TimeRow(label: 'End Time', time: '10:00 PM'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _NC.primaryMid,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14))),
                  child: const Text('Save',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Home Helpers ─────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final Color bg;

  const _StatCard(
      this.value, this.label, this.icon, this.color, this.bg);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _NC.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _NC.border),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 10,
                  offset: Offset(0, 3))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(height: 10),
              Text(value,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: color)),
              const SizedBox(height: 2),
              Text(label,
                  style: const TextStyle(
                      fontSize: 10, color: _NC.textSub)),
            ],
          ),
        ),
      );
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  const _QuickAction(
      {required this.icon,
      required this.label,
      required this.color,
      required this.bg,
      required this.onTap});

  @override
  Widget build(BuildContext context) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
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
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(height: 8),
                Text(label,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _NC.text),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
}

class _TimeRow extends StatelessWidget {
  final String label;
  final String time;

  const _TimeRow({required this.label, required this.time});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _NC.text))),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                color: _NC.primaryLight,
                borderRadius: BorderRadius.circular(10)),
            child: Text(time,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _NC.primaryMid)),
          ),
        ],
      );
}
