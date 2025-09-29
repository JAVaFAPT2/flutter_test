import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/loading_button.dart';
import '../widgets/error_message.dart';

/// OTP verification page for Vietnamese fish sauce e-commerce app
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    required this.phone,
    this.isRegistration = false,
  });

  static const String routeName = '/otp-verification';

  final String phone;
  final bool isRegistration;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  Timer? _timer;
  int _countdown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _countdown = 60;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.verifyOTP),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo/Brand Section
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.sms,
                            size: 80,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppConstants.appName,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Mã OTP đã được gửi đến',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.phone,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // OTP Field
                    AuthTextField(
                      controller: _otpController,
                      labelText: AppStrings.enterOTP,
                      hintText: '123456',
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      prefixIcon: const Icon(Icons.sms),
                      validator: _validateOTP,
                    ),

                    const SizedBox(height: 8),

                    // Resend OTP Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _canResend
                              ? 'Không nhận được mã? '
                              : 'Gửi lại mã sau ${_countdown}s',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (_canResend)
                          TextButton(
                            onPressed: _handleResendOTP,
                            child: Text(
                              AppStrings.sendOTP,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Error Message
                    if (authProvider.state.error != null)
                      ErrorMessage(message: authProvider.state.error!),

                    const SizedBox(height: 16),

                    // Verify Button
                    LoadingButton(
                      isLoading: authProvider.state.isLoading,
                      onPressed: _handleVerifyOTP,
                      child: const Text(
                        AppStrings.verifyOTP,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Change Phone Number
                    TextButton(
                      onPressed: _handleChangePhone,
                      child: Text(
                        'Thay đổi số điện thoại',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? _validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.length != 6) {
      return AppStrings.invalidOTP;
    }
    return null;
  }

  void _handleVerifyOTP() {
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();

      context.read<AuthProvider>().verifyOtp(
            phone: widget.phone,
            otp: _otpController.text.trim(),
          );
    }
  }

  void _handleResendOTP() {
    if (_canResend) {
      context.read<AuthProvider>().requestOtp(phone: widget.phone);
      _startCountdown();
    }
  }

  void _handleChangePhone() {
    context.pop();
  }
}
