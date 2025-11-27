import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savingmantra/core/themes/colors.dart';
import 'package:savingmantra/core/utils/app_toast.dart';
import 'package:savingmantra/core/utils/validators.dart';
import 'package:savingmantra/presentation/pages/auth/otp_verification.dart';
import 'package:savingmantra/presentation/providers/auth_provider.dart';
import 'package:savingmantra/presentation/widgets/common/custom_button.dart';
import 'package:savingmantra/presentation/widgets/common/custom_textfield.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isRegisterFlow = false;

  void _sendOTP() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneController.text.trim();
      final authNotifier = ref.read(authProvider.notifier);
      try {
        if (_isRegisterFlow) {
          await authNotifier.sendRegisterOTP(phoneNumber);
        } else {
          await authNotifier.sendLoginOTP(phoneNumber);
        }
        appToast.successToast(txt: 'OTP sent successfully!');
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerificationPage(isRegisterFlow: _isRegisterFlow, phoneNumber: phoneNumber),
            ),
          );
        }
      } catch (e) {
        appToast.internalServerError(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 900;
    final isTablet = size.width > 600 && size.width <= 900;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(child: isWeb ? _buildWebLayout(context, size, authState) : _buildMobileLayout(context, size, isTablet, authState)),
    );
  }

  Widget _buildWebLayout(BuildContext context, Size size, AuthState authState) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.primary, AppColors.primary.withOpacity(0.8), AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: _buildBrandingContent(),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            color: AppColors.white,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480), child: _buildFormContent(size, false, authState)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, Size size, bool isTablet, AuthState authState) {
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
              child: _buildMobileHeader(isTablet),
            ),
            Padding(
              padding: EdgeInsets.all(isTablet ? 40 : 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isTablet ? 600 : double.infinity),
                child: _buildFormContent(size, true, authState),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandingContent() {
    return Stack(
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
                'Welcome to\nSaving Mantra',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
              ),
              const SizedBox(height: 24),
              Text(
                'Your trusted companion for smart financial management and achieving your savings goals.',
                style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400, height: 1.6),
              ),
              const SizedBox(height: 60),
              _buildFeatureItem(Icons.phone_android_rounded, 'Phone Verification', 'Secure login with OTP verification'),
              const SizedBox(height: 24),
              _buildFeatureItem(Icons.security_rounded, 'Bank-Level Security', 'Your data is encrypted and protected 24/7'),
              const SizedBox(height: 24),
              _buildFeatureItem(Icons.savings_rounded, 'Smart Savings', 'Achieve your financial goals faster'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          'Welcome Back!',
          style: TextStyle(fontSize: isTablet ? 36 : 28, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
        ),
        const SizedBox(height: 12),
        Text(
          'Enter your phone number to continue',
          style: TextStyle(fontSize: isTablet ? 18 : 16, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildFormContent(Size size, bool isMobile, AuthState authState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormHeader(),
        const SizedBox(height: 40),
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Phone Number',
                hintText: 'Enter your 10-digit mobile number',
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                validator: Validators.phoneValidator,
                textInputAction: TextInputAction.done,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: Icon(Icons.phone_android_rounded, color: AppColors.primary.withOpacity(0.7), size: 20),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: authState.isLoading ? [] : [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: CustomButton(
                  text: 'Send OTP',
                  onPressed: _sendOTP,
                  isLoading: authState.isLoading,
                  isEnabled: !authState.isLoading,
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isRegisterFlow ? "Already have an account? " : "Don't have an account? ",
                      style: TextStyle(color: AppColors.darkGrey, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRegisterFlow = !_isRegisterFlow;
                        });
                      },
                      child: Text(
                        _isRegisterFlow ? 'Sign In' : 'Sign Up Free',
                        style: const TextStyle(color: AppColors.primary, fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSecurityBadge(),
            ],
          ),
        ),
        if (isMobile) const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildFormHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${!_isRegisterFlow ? 'Sign In' : 'Sign Up'} with Phone',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.black),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your phone number to receive OTP',
          style: TextStyle(fontSize: 16, color: AppColors.darkGrey.withOpacity(0.7), fontWeight: FontWeight.w400),
        ),
      ],
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

  Widget _buildSecurityBadge() {
    return Container(
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
    );
  }
}
