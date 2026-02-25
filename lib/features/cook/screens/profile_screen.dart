// ============================================================
// COOK PROFILE — Same design as Customer Profile + Vacation Mode + Working Hours
// ============================================================

import 'package:flutter/material.dart';

import '../../customer/naham_customer_screens.dart';
import 'earnings_screen.dart';
import 'bank_account_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _vacationMode = false;
  final Map<String, String> _workingHours = {
    'Mon': '9:00 AM – 5:00 PM',
    'Tue': '9:00 AM – 5:00 PM',
    'Wed': '9:00 AM – 5:00 PM',
    'Thu': '9:00 AM – 5:00 PM',
    'Fri': 'Closed',
    'Sat': '10:00 AM – 3:00 PM',
    'Sun': 'Closed',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      body: Column(
        children: [
          nahamCustomerHeader(title: 'My Profile'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(context),
                  const SizedBox(height: 20),
                  _buildVacationMode(),
                  const SizedBox(height: 16),
                  _buildWorkingHours(context),
                  const SizedBox(height: 16),
                  _buildProfileOptions(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        color: NahamCustomerColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  ),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, size: 16, color: NahamCustomerColors.primary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Maria',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Maria's Kitchen",
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statItem('142', 'Orders'),
              Container(width: 1, height: 30, color: Colors.white30),
              _statItem('4.9', 'Rating'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildVacationMode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: NahamCustomerColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: NahamCustomerColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.beach_access_rounded, color: NahamCustomerColors.primary, size: 24),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Vacation Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text('Pause orders while you\'re away', style: TextStyle(color: NahamCustomerColors.textGrey, fontSize: 12)),
                ],
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: NahamCustomerColors.primary,
                  surface: NahamCustomerColors.primary,
                ),
              ),
              child: Switch(
                value: _vacationMode,
                onChanged: (v) => setState(() => _vacationMode = v),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHours(BuildContext context) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: NahamCustomerColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.schedule_rounded, size: 20, color: NahamCustomerColors.primary),
                const SizedBox(width: 8),
                const Text('Working Hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 12),
            ...days.map((day) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: 36, child: Text(day, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () => _editWorkingHours(context, day),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: NahamCustomerColors.background,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: NahamCustomerColors.primary.withOpacity(0.2)),
                          ),
                          child: Text(
                            _workingHours[day] ?? '–',
                            style: const TextStyle(fontSize: 13, color: NahamCustomerColors.textDark),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _editWorkingHours(BuildContext context, String day) {
    final ctrl = TextEditingController(text: _workingHours[day]);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('$day – Working hours'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
            hintText: 'e.g. 9:00 AM – 5:00 PM or Closed',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() => _workingHours[day] = ctrl.text.trim().isEmpty ? 'Closed' : ctrl.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _optionCard(icon: Icons.edit_outlined, title: 'Edit Profile', subtitle: 'Name, phone, location', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()))),
          _optionCard(icon: Icons.description_outlined, title: 'Documents', subtitle: 'ID, licenses, certificates', onTap: () {}),
          _optionCard(icon: Icons.account_balance_outlined, title: 'Bank Account', subtitle: 'IBAN, account details', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BankAccountScreen()))),
          _optionCard(icon: Icons.bar_chart_rounded, title: 'Earnings & Insights', subtitle: 'Revenue, graphs, best sellers', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EarningsScreen()))),
          _optionCard(icon: Icons.verified_user_outlined, title: 'Health Verification', subtitle: 'Inspection history & status', onTap: () {}),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Logout', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _optionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: NahamCustomerColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: NahamCustomerColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: NahamCustomerColors.primary, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(subtitle, style: const TextStyle(color: NahamCustomerColors.textGrey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: NahamCustomerColors.textGrey),
          ],
        ),
      ),
    );
  }
}

// ─── Edit Profile Screen (unchanged structure, keep purple) ─────
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'Maria Al-Zahrani');
  final _kitchenCtrl = TextEditingController(text: "Maria's Kitchen");
  final _phoneCtrl = TextEditingController(text: '+966 50 123 4567');
  final _locationCtrl = TextEditingController(text: 'Riyadh, Al-Olaya');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _kitchenCtrl.dispose();
    _phoneCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NahamCustomerColors.background,
      body: Column(
        children: [
          Container(
            color: NahamCustomerColors.primary,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 20, 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                    ),
                    const Expanded(
                      child: Text('Edit Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 20, 16, MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NahamCustomerColors.primaryLight,
                            border: Border.all(color: NahamCustomerColors.primary.withOpacity(0.3), width: 3),
                          ),
                          child: const Center(child: Text('👩‍🍳', style: TextStyle(fontSize: 44))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: NahamCustomerColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Change Photo', style: TextStyle(color: NahamCustomerColors.primary, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _FormCard(
                    title: 'Basic Information',
                    icon: Icons.person_outline_rounded,
                    fields: [
                      _FormField(label: 'Cook Name', controller: _nameCtrl),
                      _FormField(label: 'Kitchen Name', controller: _kitchenCtrl),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _FormCard(
                    title: 'Contact Information',
                    icon: Icons.phone_outlined,
                    fields: [
                      _FormField(label: 'Phone Number', controller: _phoneCtrl, keyboard: TextInputType.phone),
                      _FormField(label: 'Location', controller: _locationCtrl),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NahamCustomerColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<_FormField> fields;

  const _FormCard({required this.title, required this.icon, required this.fields});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: NahamCustomerColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: NahamCustomerColors.primary),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: NahamCustomerColors.textDark)),
              ],
            ),
            const SizedBox(height: 16),
            ...fields.map((f) => Padding(padding: const EdgeInsets.only(bottom: 12), child: f)),
          ],
        ),
      );
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboard;

  const _FormField({required this.label, required this.controller, this.keyboard});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: NahamCustomerColors.textGrey)),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            keyboardType: keyboard,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: NahamCustomerColors.textDark),
            decoration: InputDecoration(
              filled: true,
              fillColor: NahamCustomerColors.background,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: NahamCustomerColors.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ],
      );
}
