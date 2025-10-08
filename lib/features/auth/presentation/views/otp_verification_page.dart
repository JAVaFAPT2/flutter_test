import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/app_constants.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/cubit/otp_cubit.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/auth_text_field.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/loading_button.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/error_message.dart';

/// OTP verification page for Vietnamese fish sauce e-commerce app
class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({
    super.key,
    required this.phone,
    this.isRegistration = false,
  });

  static const String routeName = '/otp-verification';

  final String phone;
  final bool isRegistration;

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
        child: BlocProvider(
          create: (_) => OtpCubit()..start(),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final isLoading = authState.isLoading;
              final error = authState.errorMessage;
              final formKey = GlobalKey<FormState>();
              final otpController = TextEditingController();
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: formKey,
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
                              'M� OTP d� du?c g?i d?n',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              phone,
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
                        controller: otpController,
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
                            context.watch<OtpCubit>().state.canResend
                                ? 'Kh�ng nh?n du?c m�? '
                                : 'G?i l?i m� sau ${context.watch<OtpCubit>().state.countdown}s',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          if (context.watch<OtpCubit>().state.canResend)
                            TextButton(
                              onPressed: () => _handleResendOTP(context),
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
                      if (error != null) ErrorMessage(message: error),

                      const SizedBox(height: 16),

                      // Verify Button
                      LoadingButton(
                        isLoading: isLoading,
                        onPressed: () =>
                            _handleVerifyOTP(context, formKey, otpController),
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
                        onPressed: () => _handleChangePhone(context),
                        child: Text(
                          'Thay d?i s? di?n tho?i',
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

  void _handleVerifyOTP(BuildContext context, GlobalKey<FormState> formKey,
      TextEditingController otpController) {
    if (formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
          AuthOtpVerifyRequested(phone: phone, otp: otpController.text.trim()));
    }
  }

  void _handleResendOTP(BuildContext context) {
    if (context.read<OtpCubit>().state.canResend) {
      context.read<AuthBloc>().add(AuthOtpRequested(phone: phone));
      context.read<OtpCubit>().start();
    }
  }

  void _handleChangePhone(BuildContext context) {
    context.pop();
  }
}
