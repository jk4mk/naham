// ============================================================
// COOK BANK ACCOUNT — Naham App
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
// BANK ACCOUNT SCREEN
// ══════════════════════════════════════════════════════════════
class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  bool _showIban = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _NC.bg,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          _buildVerifiedBanner(),
          _buildBankDetails(),
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
              colors: [_NC.primary, _NC.primaryBright],
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
                    child: Text('Bank Account',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifiedBanner() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [_NC.primaryLight, _NC.primaryLight.withOpacity(0.5)]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _NC.primaryMid.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: _NC.primaryMid,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: _NC.primaryMid.withOpacity(0.3),
                        blurRadius: 8)
                  ]),
              child: const Icon(Icons.verified_rounded,
                  color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Account Verified ✓',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: _NC.primaryMid)),
                  SizedBox(height: 2),
                  Text(
                    'Your bank account is verified\nand ready to receive payments.',
                    style: TextStyle(
                        fontSize: 12,
                        color: _NC.textSub,
                        height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankDetails() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _NC.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _NC.border),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08000000),
                blurRadius: 16,
                offset: Offset(0, 6))
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
                  child: const Icon(Icons.account_balance_rounded,
                      color: _NC.primaryMid, size: 20),
                ),
                const SizedBox(width: 12),
                const Text('Bank Details',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _NC.text)),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: _NC.primaryLight,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text('Edit',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _NC.primaryMid)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _BankField(
              label: 'IBAN Number',
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    _showIban
                        ? 'SA44 1000 0001 2345 6789 1234'
                        : 'SA44 **** **** **** 1234',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _NC.text),
                  )),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _showIban = !_showIban),
                    child: Icon(
                        _showIban
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        size: 18,
                        color: _NC.textSub),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _BankField(
              label: 'Bank Name',
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                        color: const Color(0xFFE8F4FD),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.account_balance_rounded,
                        size: 16, color: Color(0xFF0066CC)),
                  ),
                  const SizedBox(width: 10),
                  const Text('Al Rajhi Bank',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _NC.text)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _BankField(
              label: 'Account Holder Name',
              child: const Text('Sarah Al-Zahrani',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _NC.text)),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _NC.bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _NC.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded,
                      size: 18, color: _NC.textSub),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Next Payout',
                            style: TextStyle(
                                fontSize: 12,
                                color: _NC.textSub)),
                        Text('Expected: Jan 25, 2026',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _NC.text)),
                      ],
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('SAR',
                          style: TextStyle(
                              fontSize: 11,
                              color: _NC.textSub)),
                      Text('3,450',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: _NC.primaryMid)),
                    ],
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

class _BankField extends StatelessWidget {
  final String label;
  final Widget child;

  const _BankField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _NC.textSub)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
                color: _NC.bg,
                borderRadius: BorderRadius.circular(12)),
            child: child,
          ),
        ],
      );
}
