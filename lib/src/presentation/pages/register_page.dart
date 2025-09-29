import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/cubit/login_cubit.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/loading_button.dart';
import '../widgets/error_message.dart';

/// Register page for Vietnamese fish sauce e-commerce app
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final agreeToTerms = ValueNotifier<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.register),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
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
                    // Logo/Brand Section
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.person_add,
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Tạo tài khoản mới',
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
                            'Tham gia cùng chúng tôi để trải nghiệm mua sắm nước mắm Việt Nam',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // Full Name Field
                    AuthTextField(
                      controller: fullNameController,
                      labelText: AppStrings.fullName,
                      hintText: 'Nguyễn Văn A',
                      prefixIcon: const Icon(Icons.person),
                      validator: _validateFullName,
                    ),

                    const SizedBox(height: 16),

                    // Phone Number Field
                    AuthTextField(
                      controller: phoneController,
                      labelText: AppStrings.phoneNumber,
                      hintText: '0123456789',
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone),
                      validator: _validatePhone,
                    ),

                    const SizedBox(height: 16),

                    // Email Field (Optional)
                    AuthTextField(
                      controller: emailController,
                      labelText: AppStrings.email,
                      hintText: 'example@email.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      validator: _validateEmail,
                    ),

                    const SizedBox(height: 16),

                    // Password Field
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, loginState) {
                        return AuthTextField(
                          controller: passwordController,
                      labelText: AppStrings.newPassword,
                      hintText: '••••••••',
                          obscureText: loginState.obscurePassword,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                              loginState.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                        ),
                        onPressed: () => context.read<LoginCubit>().toggleObscurePassword(),
                      ),
                      validator: _validatePassword,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Confirm Password Field
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, loginState) {
                        return AuthTextField(
                          controller: confirmPasswordController,
                      labelText: AppStrings.confirmNewPassword,
                      hintText: '••••••••',
                          obscureText: loginState.obscurePassword,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                              loginState.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                        ),
                        onPressed: () => context.read<LoginCubit>().toggleObscurePassword(),
                      ),
                      validator: _validateConfirmPassword,
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Terms and Conditions Checkbox
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: agreeToTerms,
                            builder: (context, v, _) {
                              return Checkbox(
                                value: v,
                                onChanged: (value) => agreeToTerms.value = value ?? false,
                              );
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  const TextSpan(text: 'Tôi đồng ý với '),
                                  TextSpan(
                                    text: 'Điều khoản dịch vụ',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const TextSpan(text: ' và '),
                                  TextSpan(
                                    text: 'Chính sách bảo mật',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Error Message
                    if (error != null) ErrorMessage(message: error),

                    const SizedBox(height: 16),

                    // Register Button
                    LoadingButton(
                      isLoading: isLoading,
                      onPressed: agreeToTerms.value
                          ? () => _handleRegister(
                                context,
                                formKey,
                                phoneController,
                                passwordController,
                                confirmPasswordController,
                                fullNameController,
                                emailController,
                              )
                          : null,
                      child: const Text(
                        AppStrings.register,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Đã có tài khoản? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => _navigateToLogin(context),
                          child: Text(
                            AppStrings.login,
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
    );
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.trim().length < 2) {
      return 'Họ và tên phải có ít nhất 2 ký tự';
    }
    return null;
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

  String? _validateEmail(String? value) {
    if (value != null && value.isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return AppStrings.invalidEmail;
      }
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
    if (value.length > AppConstants.maxPasswordLength) {
      return AppStrings.passwordTooLong;
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }

  void _handleRegister(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController phoneController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    TextEditingController fullNameController,
    TextEditingController emailController,
  ) {
    if (formKey.currentState?.validate() == true) {
      if (confirmPasswordController.text != passwordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.passwordsNotMatch)),
        );
        return;
      }
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(AuthRegisterRequested(
            phone: phoneController.text.trim(),
            password: passwordController.text,
            fullName: fullNameController.text.trim(),
            email: emailController.text.trim().isEmpty
                ? null
                : emailController.text.trim(),
          ));
    }
  }

  void _navigateToLogin(BuildContext context) {
    context.pop();
  }
}
