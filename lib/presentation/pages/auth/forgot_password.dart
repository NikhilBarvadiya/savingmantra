import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savingmantra/core/themes/colors.dart';
import 'package:savingmantra/core/utils/app_toast.dart';
import 'package:savingmantra/core/utils/validators.dart';
import 'package:savingmantra/presentation/providers/auth_provider.dart';
import 'package:savingmantra/presentation/widgets/common/custom_button.dart';
import 'package:savingmantra/presentation/widgets/common/custom_textfield.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitting = false;

  void _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    final authNotifier = ref.read(authProvider.notifier);
    try {
      await authNotifier.forgotPassword(_emailController.text.trim());
      appToast.successToast(txt: 'Reset link sent! Check your inbox.');
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) Navigator.pop(context);
    } catch (e) {
      appToast.internalServerError(e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(child: isWeb ? _buildWebLayout(context, size) : _buildMobileLayout(context, size, isTablet)),
    );
  }

  Widget _buildWebLayout(BuildContext context, Size size) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.primary, AppColors.primary.withOpacity(0.8), AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -100,
                  right: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
                  ),
                ),
                Positioned(
                  bottom: -150,
                  left: -100,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.05)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
                        ),
                        child: const Icon(Icons.account_balance_wallet_rounded, size: 40, color: AppColors.primary),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Reset Your\nPassword',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No worries! We\'ll send you a secure link to reset your password and get you back on track.',
                        style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400, height: 1.6),
                      ),
                      const SizedBox(height: 60),
                      _buildFeatureItem(Icons.security_rounded, 'Bank-Level Security', 'Your data is encrypted and protected 24/7'),
                      const SizedBox(height: 24),
                      _buildFeatureItem(Icons.email_rounded, 'Instant Delivery', 'Reset links are sent immediately to your inbox'),
                      const SizedBox(height: 24),
                      _buildFeatureItem(Icons.access_time_rounded, '24/7 Support', 'Our team is always here to help you'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            color: AppColors.white,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildFormHeader(size, false), const SizedBox(height: 40), _buildForgotPasswordForm(), const SizedBox(height: 40), _buildFooter(context, false)],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, Size size, bool isTablet) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        constraints: BoxConstraints(minHeight: size.height),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.white, AppColors.primary.withOpacity(0.02)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24, vertical: isTablet ? 60 : 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? 40 : 24),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 4))],
                    ),
                    child: const Icon(Icons.account_balance_wallet_rounded, size: 32, color: AppColors.primary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: isTablet ? 36 : 28, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Enter your email and we\'ll send you a reset link',
                    style: TextStyle(fontSize: isTablet ? 18 : 16, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isTablet ? 40 : 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isTablet ? 600 : double.infinity),
                child: Column(children: [const SizedBox(height: 8), _buildForgotPasswordForm(), const SizedBox(height: 32), _buildFooter(context, true), const SizedBox(height: 24)]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Email Address',
            hintText: 'your.email@example.com',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: Validators.emailValidator,
            textInputAction: TextInputAction.done,
            prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(Icons.email_outlined, color: AppColors.primary.withOpacity(0.7), size: 20),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: _isSubmitting ? [] : [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
            ),
            child: CustomButton(text: 'Send Reset Link', onPressed: _submit, isLoading: _isSubmitting, isEnabled: !_isSubmitting, backgroundColor: AppColors.primary, textColor: AppColors.white),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.success.withOpacity(0.2), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.success.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.verified_user_rounded, color: AppColors.success, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Secured with 256-bit encryption',
                    style: TextStyle(color: AppColors.success.withOpacity(0.9), fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormHeader(Size size, bool isMobile) {
    if (isMobile) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reset Password',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.black),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your email to receive a password reset link',
          style: TextStyle(fontSize: 16, color: AppColors.darkGrey.withOpacity(0.7), fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, bool isMobile) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Remember your password? ', style: TextStyle(color: AppColors.grey.withOpacity(0.8), fontSize: 13)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Text(
              'Back to Login',
              style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
