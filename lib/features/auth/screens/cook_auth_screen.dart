import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_design_system.dart';
import '../../../core/theme/naham_theme.dart';
import '../../cook/screens/cook_main_navigation_screen.dart';
import '../domain/entities/user_entity.dart';
import '../presentation/providers/auth_provider.dart';
import 'chef_reg_success_screen.dart';
import 'chef_rejection_screen.dart';
import 'cook_pending_screen.dart';

/// Cook auth: Login | Register. Login → Cook Home or Pending or Rejection. Register → account → documents → under review.
class CookAuthScreen extends ConsumerStatefulWidget {
  const CookAuthScreen({super.key});

  @override
  ConsumerState<CookAuthScreen> createState() => _CookAuthScreenState();
}

class _CookAuthScreenState extends ConsumerState<CookAuthScreen> {
  bool _isLogin = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _obscurePassword = true;
  bool _idUploaded = false;
  bool _healthUploaded = false;

  static const Color _primary = NahamTheme.primary;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authStateProvider.notifier).login(
            _emailController.text.trim(),
            _passwordController.text,
            AppRole.chef,
          );
      if (!mounted) return;
      final user = ref.read(authStateProvider).valueOrNull;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed'), backgroundColor: AppDesignSystem.errorRed),
        );
        return;
      }
      if (user.isChefApproved) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const CookMainNavigationScreen()),
          (r) => false,
        );
      } else if (user.isChefPending) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const CookPendingScreen()),
          (r) => false,
        );
      } else if (user.isChefRejected) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const ChefRejectionScreen()),
          (r) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const CookMainNavigationScreen()),
          (r) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', '')), backgroundColor: AppDesignSystem.errorRed),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _submitRegister() {
    if (!_formKey.currentState!.validate()) return;
    if (!_idUploaded || !_healthUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload both ID Document and Health Certificate'),
          backgroundColor: AppDesignSystem.errorRed,
        ),
      );
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ChefRegSuccessScreen()),
    );
  }

  void _submit() {
    if (_isLogin) {
      _submitLogin();
    } else {
      _submitRegister();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
        title: Text(
          _isLogin ? 'Cook Login' : 'Cook Register',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDesignSystem.screenHorizontalPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                _buildToggle(),
                const SizedBox(height: 32),
                if (_isLogin) ...[
                  _buildEmailField(),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                ] else ...[
                  _buildNameField(),
                  const SizedBox(height: 16),
                  _buildEmailField(),
                  const SizedBox(height: 16),
                  _buildPhoneField(),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                  const SizedBox(height: 24),
                  _buildUploadSection(),
                  const SizedBox(height: 16),
                  _buildNote(),
                ],
                const SizedBox(height: 32),
                _buildSubmitButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppDesignSystem.surfaceLight,
        borderRadius: BorderRadius.circular(AppDesignSystem.radiusMedium),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isLogin = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _isLogin ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _isLogin ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))] : null,
                ),
                child: const Text('Login', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isLogin = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isLogin ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: !_isLogin ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))] : null,
                ),
                child: const Text('Register', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: _inputDecoration('Full Name'),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: _inputDecoration('Email'),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Required';
        if (!v.contains('@')) return 'Enter a valid email';
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: _inputDecoration('Phone'),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: _inputDecoration('Password').copyWith(
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Required';
        if (!_isLogin && v.length < 6) return 'At least 6 characters';
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppDesignSystem.textSecondary),
      filled: true,
      fillColor: AppDesignSystem.surfaceLight,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDesignSystem.radiusMedium), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDesignSystem.radiusMedium),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload Documents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppDesignSystem.textPrimary)),
        const SizedBox(height: 12),
        _UploadChip(label: 'ID Document', uploaded: _idUploaded, color: _primary, onTap: () => setState(() => _idUploaded = true)),
        const SizedBox(height: 10),
        _UploadChip(label: 'Health Certificate', uploaded: _healthUploaded, color: _primary, onTap: () => setState(() => _healthUploaded = true)),
      ],
    );
  }

  Widget _buildNote() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppDesignSystem.radiusMedium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 20, color: _primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Your account will be reviewed within 24 hours.',
              style: TextStyle(fontSize: 13, color: _primary.withOpacity(0.9), fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return FilledButton(
      onPressed: _isLoading ? null : _submit,
      style: FilledButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDesignSystem.radiusButton)),
        elevation: 0,
      ),
      child: _isLoading
          ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Text(_isLogin ? 'Login' : 'Register', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
    );
  }
}

class _UploadChip extends StatelessWidget {
  final String label;
  final bool uploaded;
  final Color color;
  final VoidCallback onTap;

  const _UploadChip({required this.label, required this.uploaded, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: uploaded ? null : onTap,
        borderRadius: BorderRadius.circular(AppDesignSystem.radiusMedium),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppDesignSystem.surfaceLight,
            borderRadius: BorderRadius.circular(AppDesignSystem.radiusMedium),
            border: Border.all(color: uploaded ? color : Colors.transparent, width: 1.5),
          ),
          child: Row(
            children: [
              Icon(uploaded ? Icons.check_circle_rounded : Icons.upload_file_rounded, color: uploaded ? color : AppDesignSystem.textSecondary, size: 22),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: uploaded ? color : AppDesignSystem.textPrimary))),
              if (uploaded) Icon(Icons.check_rounded, color: color, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
