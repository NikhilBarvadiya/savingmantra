import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savingmantra/core/themes/colors.dart';
import 'package:savingmantra/presentation/pages/auth/login_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        'Welcome to\nSavingMantra',
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your trusted companion for smart financial management and achieving your savings goals.',
                        style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400, height: 1.6),
                      ),
                      const SizedBox(height: 60),
                      _buildFeatureItem(Icons.insights_rounded, 'Smart Analytics', 'Get real-time insights into your spending patterns'),
                      const SizedBox(height: 24),
                      _buildFeatureItem(Icons.security_rounded, 'Bank-Level Security', 'Your data is encrypted and protected 24/7'),
                      const SizedBox(height: 24),
                      _buildFeatureItem(Icons.devices_rounded, 'Cross-Platform Sync', 'Access your finances from any device, anywhere'),
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
                    children: [_buildFormHeader(size, false), const SizedBox(height: 40), const LoginForm(), const SizedBox(height: 40), _buildFooter(context, false)],
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
                    'Welcome Back!',
                    style: TextStyle(fontSize: isTablet ? 36 : 28, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sign in to continue your financial journey',
                    style: TextStyle(fontSize: isTablet ? 18 : 16, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isTablet ? 40 : 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isTablet ? 600 : double.infinity),
                child: Column(children: [const SizedBox(height: 8), const LoginForm(), const SizedBox(height: 32), _buildFooter(context, true), const SizedBox(height: 24)]),
              ),
            ),
          ],
        ),
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
          'Sign In',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.black),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your credentials to access your account',
          style: TextStyle(fontSize: 16, color: AppColors.darkGrey.withOpacity(0.7), fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, bool isMobile) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('By continuing, you agree to our ', style: TextStyle(color: AppColors.grey.withOpacity(0.8), fontSize: 13)),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Terms',
                style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
            Text(' and ', style: TextStyle(color: AppColors.grey.withOpacity(0.8), fontSize: 13)),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Privacy Policy',
                style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
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
                "Don't have an account? ",
                style: TextStyle(color: AppColors.darkGrey, fontSize: 15, fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Sign Up Free',
                  style: TextStyle(color: AppColors.primary, fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
