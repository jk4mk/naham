import 'dart:math';

import 'package:flutter/material.dart';

import '../../screens/video_inspection_call_screen.dart';

class HygieneScreen extends StatefulWidget {
  const HygieneScreen({super.key});

  @override
  State<HygieneScreen> createState() => _HygieneScreenState();
}

class _HygieneScreenState extends State<HygieneScreen> {
  _HygieneFilter _selectedFilter = _HygieneFilter.nonCompliant;

  final _random = Random();

  final List<String> _fakeCookNames = const [
    'أحمد محمد',
    'فاطمة علي',
    'سعود عبد الله',
    'نورا حسن',
    'خالد إبراهيم',
    'ريم صالح',
  ];

  final List<_Inspection> _inspections = const [
    _Inspection(
      cookName: 'أحمد محمد',
      result: _HygieneResult.nonCompliant,
      dateLabel: '2026-02-10',
      statusBadge: _HygieneStatusBadge.warning,
    ),
    _Inspection(
      cookName: 'فاطمة علي',
      result: _HygieneResult.compliant,
      dateLabel: '2026-02-08',
      statusBadge: _HygieneStatusBadge.none,
    ),
    _Inspection(
      cookName: 'سعود عبد الله',
      result: _HygieneResult.nonCompliant,
      dateLabel: '2026-02-05',
      statusBadge: _HygieneStatusBadge.frozen,
    ),
    _Inspection(
      cookName: 'نورا حسن',
      result: _HygieneResult.missedDeclined,
      dateLabel: '2026-02-03',
      statusBadge: _HygieneStatusBadge.warning,
    ),
    _Inspection(
      cookName: 'خالد إبراهيم',
      result: _HygieneResult.compliant,
      dateLabel: '2026-01-30',
      statusBadge: _HygieneStatusBadge.none,
    ),
  ];

  List<_Inspection> get _filteredInspections {
    if (_selectedFilter == _HygieneFilter.compliant) {
      return _inspections
          .where((i) => i.result == _HygieneResult.compliant)
          .toList();
    }
    return _inspections
        .where(
          (i) =>
              i.result == _HygieneResult.nonCompliant ||
              i.result == _HygieneResult.missedDeclined,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: const Color(0xFFF5F5FA),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildStartInspectionButton(context),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSegmentedControl(context),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: _filteredInspections.length,
              itemBuilder: (context, index) {
                final inspection = _filteredInspections[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == _filteredInspections.length - 1 ? 0 : 12,
                  ),
                  child: _InspectionCard(inspection: inspection),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
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
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Hygiene Inspections',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStartInspectionButton(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          if (_fakeCookNames.isEmpty) return;

          final name =
              _fakeCookNames[_random.nextInt(_fakeCookNames.length)];

          final result = await Navigator.of(context).push<String>(
            MaterialPageRoute(
              builder: (_) => VideoInspectionCallScreen(cookName: name),
            ),
          );

          // UI-only: result can be 'ended', 'clean', or 'not_clean'.
          // You can later use it to update the inspections list.
          debugPrint('Inspection call result: $result');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E1FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.videocam_outlined,
                  color: Color(0xFF6A5AE0),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Start New Inspection',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = _HygieneFilter.nonCompliant;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedFilter == _HygieneFilter.nonCompliant
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Center(
                  child: Text(
                    'Non-Compliant',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _selectedFilter == _HygieneFilter.nonCompliant
                          ? const Color(0xFFDC2626)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = _HygieneFilter.compliant;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedFilter == _HygieneFilter.compliant
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Center(
                  child: Text(
                    'Compliant',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _selectedFilter == _HygieneFilter.compliant
                          ? const Color(0xFF16A34A)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _HygieneFilter {
  nonCompliant,
  compliant,
}

enum _HygieneResult {
  compliant,
  nonCompliant,
  missedDeclined,
}

enum _HygieneStatusBadge {
  warning,
  frozen,
  none,
}

class _Inspection {
  final String cookName;
  final _HygieneResult result;
  final String dateLabel;
  final _HygieneStatusBadge statusBadge;

  const _Inspection({
    required this.cookName,
    required this.result,
    required this.dateLabel,
    required this.statusBadge,
  });
}

class _InspectionCard extends StatelessWidget {
  final _Inspection inspection;

  const _InspectionCard({required this.inspection});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color resultColor;
    final String resultText;

    switch (inspection.result) {
      case _HygieneResult.compliant:
        resultColor = const Color(0xFF16A34A);
        resultText = 'Compliant';
        break;
      case _HygieneResult.nonCompliant:
        resultColor = const Color(0xFFDC2626);
        resultText = 'Non-Compliant';
        break;
      case _HygieneResult.missedDeclined:
        resultColor = const Color(0xFFDC2626);
        resultText = 'Missed / Declined';
        break;
    }

    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.06),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFFE5E7EB),
              child: Text(
                inspection.cookName.trim().isNotEmpty
                    ? inspection.cookName.trim()[0]
                    : '?',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inspection.cookName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    resultText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: resultColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  inspection.dateLabel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 6),
                _buildStatusBadge(inspection.statusBadge, theme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    _HygieneStatusBadge badge,
    ThemeData theme,
  ) {
    switch (badge) {
      case _HygieneStatusBadge.warning:
        return _BadgeChip(
          label: 'Warning',
          backgroundColor: const Color(0xFFF97316).withOpacity(0.1),
          textColor: const Color(0xFFF97316),
        );
      case _HygieneStatusBadge.frozen:
        return _BadgeChip(
          label: 'Frozen',
          backgroundColor: const Color(0xFFDC2626).withOpacity(0.08),
          textColor: const Color(0xFFDC2626),
        );
      case _HygieneStatusBadge.none:
        return const SizedBox.shrink();
    }
  }
}

class _BadgeChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const _BadgeChip({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

