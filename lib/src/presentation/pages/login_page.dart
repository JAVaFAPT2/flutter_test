import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/cubit/login_cubit.dart';
import '../widgets/auth_text_field.dart';
import '../assets/figma_assets.dart';
import '../widgets/loading_button.dart';
import '../widgets/error_message.dart';

/// Login page for Vietnamese fish sauce e-commerce app
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Background SVGs
          Positioned.fill(
            child: SvgPicture.asset(
              kSvgBackgroundLogin,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(kSvgLoginTopRight),
          ),
          // Content
          SafeArea(
            child: BlocProvider(
              create: (_) => LoginCubit(),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  final isLoading = authState.isLoading;
                  final error = authState.errorMessage;
                  return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Back button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => context.pop(),
                            child: SvgPicture.asset(kSvgBackButton),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Logo/Brand Section
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: Column(
                            children: [
                              SvgPicture.asset(kSvgLoginAccent),
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
                                AppStrings.appDescription,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        // Phone Number Field
                        AuthTextField(
                          controller: phoneController,
                          labelText: AppStrings.enterPhoneNumber,
                          hintText: '0123456789',
                          keyboardType: TextInputType.phone,
                          prefixIcon: const Icon(Icons.phone),
                          validator: _validatePhone,
                        ),

                        const SizedBox(height: 16),

                        // Password Field
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, loginState) {
                            return AuthTextField(
                              controller: passwordController,
                          labelText: AppStrings.enterPassword,
                          hintText: '••••••••',
                              obscureText: loginState.obscurePassword,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                                  loginState.obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                            ),
                                onPressed: () {
                                  context.read<LoginCubit>().toggleObscurePassword();
                                },
                          ),
                              validator: _validatePassword,
                            );
                          },
                        ),

                        const SizedBox(height: 8),

                        // Forgot Password Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _handleForgotPassword,
                            child: Text(
                              AppStrings.forgotPassword,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Error Message
                        if (error != null) ErrorMessage(message: error),

                        const SizedBox(height: 16),

                        // Login Button
                        LoadingButton(
                          isLoading: isLoading,
                          onPressed: () {
                            _handleLogin(context, formKey, phoneController);
                          },
                          child: const Text(
                            AppStrings.login,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Register Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Chưa có tài khoản? ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: _navigateToRegister,
                              child: Text(
                                AppStrings.register,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.length < 10 || value.length > 11) {
      return AppStrings.invalidPhone;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.length < AppConstants.minPasswordLength) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  void _handleLogin(BuildContext context, GlobalKey<FormState> formKey, TextEditingController phoneController) {
    if (formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      context.push('/otp-verification', extra: phoneController.text.trim());
    }
  }

  void _handleForgotPassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chức năng đang được phát triển')),
    );
  }

  void _navigateToRegister(BuildContext context) {
    context.push('/register');
  }
}
