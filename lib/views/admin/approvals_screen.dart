import 'package:flutter/material.dart';

class ApprovalsScreen extends StatefulWidget {
  const ApprovalsScreen({super.key});

  @override
  State<ApprovalsScreen> createState() => _ApprovalsScreenState();
}

class _ApprovalsScreenState extends State<ApprovalsScreen> {
  final List<_CookApproval> _approvals = const [
    _CookApproval(
      name: 'أحمد محمد',
      phone: '+966 55 123 4567',
      city: 'الرياض',
      timeAgo: 'منذ 5 دقائق',
    ),
    _CookApproval(
      name: 'فاطمة علي',
      phone: '+966 55 987 6543',
      city: 'جدة',
      timeAgo: 'منذ 20 دقيقة',
    ),
    _CookApproval(
      name: 'سعود عبد الله',
      phone: '+966 50 222 3344',
      city: 'الدمام',
      timeAgo: 'منذ ساعة واحدة',
    ),
  ];

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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _approvals.length,
                itemBuilder: (context, index) {
                  final approval = _approvals[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == _approvals.length - 1 ? 24 : 12,
                    ),
                    child: _ApprovalCard(
                      approval: approval,
                      onTapNationalId: () {
                        _showImageDialog(
                          context: context,
                          title: 'الهوية الوطنية - ${approval.name}',
                          imageUrl:
                              'https://images.pexels.com/photos/45111/pexels-photo-45111.jpeg',
                        );
                      },
                      onTapFoodLicense: () {
                        _showImageDialog(
                          context: context,
                          title: 'رخصة مزاولة نشاط - ${approval.name}',
                          imageUrl:
                              'https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg',
                        );
                      },
                      onApprove: () {},
                      onReject: () {},
                    ),
                  );
                },
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
                'Pending Approvals',
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

  Future<void> _showImageDialog({
    required BuildContext context,
    required String title,
    required String imageUrl,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 4,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text('إغلاق'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _CookApproval {
  final String name;
  final String phone;
  final String city;
  final String timeAgo;

  const _CookApproval({
    required this.name,
    required this.phone,
    required this.city,
    required this.timeAgo,
  });
}

class _ApprovalCard extends StatelessWidget {
  final _CookApproval approval;
  final VoidCallback onTapNationalId;
  final VoidCallback onTapFoodLicense;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _ApprovalCard({
    required this.approval,
    required this.onTapNationalId,
    required this.onTapFoodLicense,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle labelStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: const Color(0xFF7A7A8C),
        );
    final TextStyle valueStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: const Color(0xFF1F1F33),
          fontWeight: FontWeight.w600,
        );

    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.06),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('اسم الطاهي', style: labelStyle),
                      const SizedBox(height: 2),
                      Text(
                        approval.name,
                        style: valueStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      approval.timeAgo,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF9A9AB0),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الجوال', style: labelStyle),
                      const SizedBox(height: 2),
                      Text(
                        approval.phone,
                        style: valueStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('المدينة', style: labelStyle),
                      const SizedBox(height: 2),
                      Text(
                        approval.city,
                        style: valueStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 4),
            _DocumentRow(
              title: 'الهوية الوطنية',
              subtitle: 'اضغط لعرض الهوية',
              onTap: onTapNationalId,
              leadingIcon: Icons.badge_outlined,
            ),
            _DocumentRow(
              title: 'رخصة مزاولة نشاط (اختياري)',
              subtitle: 'اضغط لعرض الرخصة',
              onTap: onTapFoodLicense,
              leadingIcon: Icons.receipt_long_outlined,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: onApprove,
                    child: const Text(
                      'APPROVE',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(
                        color: Color(0xFFEF4444),
                        width: 1.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: onReject,
                    child: const Text(
                      'REJECT',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final VoidCallback onTap;

  const _DocumentRow({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE6E1FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                leadingIcon,
                size: 18,
                color: const Color(0xFF6A5AE0),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F1F33),
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF9A9AB0),
                        ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFB2B2C8),
            ),
          ],
        ),
      ),
    );
  }
}

