import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savingmantra/core/themes/colors.dart';
import 'package:savingmantra/core/utils/app_toast.dart';
import 'package:savingmantra/presentation/pages/auth/registration_page.dart';
import 'package:savingmantra/presentation/providers/auth_provider.dart';
import 'package:savingmantra/presentation/router/app_routes.dart';
import 'package:savingmantra/presentation/widgets/common/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationPage extends ConsumerStatefulWidget {
  final bool isRegisterFlow;
  final String phoneNumber;

  const OTPVerificationPage({super.key, required this.isRegisterFlow, required this.phoneNumber});

  @override
  ConsumerState<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends ConsumerState<OTPVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  int _remainingTime = 60;
  bool _isCountdownFinished = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
          _isCountdownFinished = true;
        }
      });
    });
  }

  void _verifyOTP() async {
    FocusScope.of(context).unfocus();
    if (_otpController.text.length != 4) {
      appToast.dioToast(icon: Icons.warning, txt: 'Please enter 4-digit OTP');
      return;
    }
    final authNotifier = ref.read(authProvider.notifier);
    try {
      if (widget.isRegisterFlow) {
        await authNotifier.verifyRegisterOTP(_otpController.text);
        appToast.successToast(txt: 'OTP verified successfully!');
        if (mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
        }
      } else {
        await authNotifier.verifyLoginOTP(_otpController.text);
        appToast.successToast(txt: 'Login successful!');
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.layout, (route) => false);
        }
      }
    } catch (e) {
      appToast.internalServerError(e.toString());
    }
  }

  void _resendOTP() async {
    final authNotifier = ref.read(authProvider.notifier);
    try {
      if (widget.isRegisterFlow) {
        await authNotifier.sendRegisterOTP(widget.phoneNumber);
      } else {
        await authNotifier.sendLoginOTP(widget.phoneNumber);
      }
      setState(() {
        _remainingTime = 60;
        _isCountdownFinished = false;
      });
      _startCountdown();
      appToast.successToast(txt: 'OTP resent successfully!');
    } catch (e) {
      appToast.internalServerError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 900;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(child: isWeb ? _buildWebLayout(context, size, authState) : _buildMobileLayout(context, size, authState)),
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
                child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480), child: _buildOTPFormContent(authState)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, Size size, AuthState authState) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: size.height),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.white, AppColors.primary.withOpacity(0.02)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
              child: _buildMobileHeader(),
            ),
            Padding(padding: const EdgeInsets.all(24), child: _buildOTPFormContent(authState)),
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
                child: const Icon(Icons.verified_user_rounded, size: 40, color: AppColors.primary),
              ),
              const SizedBox(height: 40),
              const Text(
                'Verify Your\nPhone Number',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
              ),
              const SizedBox(height: 24),
              Text(
                'Enter the 4-digit OTP sent to your phone number',
                style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400, height: 1.6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader() {
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
          child: const Icon(Icons.verified_user_rounded, size: 32, color: AppColors.primary),
        ),
        const SizedBox(height: 24),
        const Text(
          'Enter OTP',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
        ),
        const SizedBox(height: 12),
        Text(
          'We sent a code to ${widget.phoneNumber}',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildOTPFormContent(AuthState authState) {
    return Column(
      children: [
        PinCodeTextField(
          appContext: context,
          length: 4,
          controller: _otpController,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(12),
            fieldHeight: 60,
            fieldWidth: 60,
            activeFillColor: AppColors.white,
            activeColor: AppColors.primary,
            selectedColor: AppColors.primary,
            inactiveColor: AppColors.grey.withOpacity(0.4),
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: false,
          keyboardType: TextInputType.number,
          onCompleted: (value) {
            _verifyOTP();
          },
          onChanged: (value) {},
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Didn't receive code? ", style: TextStyle(color: AppColors.darkGrey.withOpacity(0.6), fontSize: 16)),
            if (!_isCountdownFinished) Text('Resend in $_remainingTime sec', style: TextStyle(color: AppColors.darkGrey.withOpacity(0.6), fontSize: 16)),
            if (_isCountdownFinished)
              GestureDetector(
                onTap: _resendOTP,
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
        const SizedBox(height: 32),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: authState.isLoading ? [] : [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
          ),
          child: CustomButton(
            text: 'Verify OTP',
            onPressed: _verifyOTP,
            isLoading: authState.isLoading,
            isEnabled: !authState.isLoading,
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
          ),
        ),
      ],
    );
  }
}
