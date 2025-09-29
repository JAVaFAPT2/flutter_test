import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
// import '../../../generated/l10n.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    // Only start navigation timer if not in test mode
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _navigateToNextScreen();
      }
    });
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for animation to complete
    await Future.delayed(const Duration(milliseconds: 3000));

    if (!mounted) return;

    // Check if user is logged in
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);
    final isFirstTime = prefs.getBool('is_first_time') ?? true;

    if (!mounted) return;

    // Navigate based on user state
    if (isFirstTime) {
      // Navigate to onboarding/welcome screen
      _navigateToWelcome();
    } else if (token != null && token.isNotEmpty) {
      // Navigate to main app (home screen)
      _navigateToHome();
    } else {
      // Navigate to login screen
      _navigateToLogin();
    }
  }

  void _navigateToWelcome() {
    Navigator.of(context).pushReplacementNamed('/welcome');
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Logo/Icon
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadowColor,
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.water_drop_outlined,
                            size: 60,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // App Name
                        Text(
                          AppConstants.appName,
                          style: AppTextStyles.displayMedium.copyWith(
                            color: AppColors.textOnPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // App Tagline
                        Text(
                          'Nước mắm truyền thống Việt Nam',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color:
                                AppColors.textOnPrimaryColor.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 60),

                        // Loading indicator
                        const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.accentColor,
                            ),
                            strokeWidth: 3,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Loading text
                        Text(
                          'Đang tải...',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color:
                                AppColors.textOnPrimaryColor.withOpacity(0.8),
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
      ),
    );
  }
}
