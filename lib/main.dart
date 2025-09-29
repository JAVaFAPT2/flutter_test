import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/core/constants/app_constants.dart';
import 'src/core/di/injection_container.dart' as di;
import 'src/presentation/providers/auth_provider.dart';
import 'src/presentation/providers/cart_provider.dart';
import 'src/presentation/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.initializeDependencies();

  runApp(const VietnameseFishSauceApp());
}

/// Main application widget for Vietnamese fish sauce e-commerce app
class VietnameseFishSauceApp extends StatelessWidget {
  const VietnameseFishSauceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Authentication provider
        ChangeNotifierProvider<AuthProvider>(
          create: (context) {
            final authProvider = di.getIt<AuthProvider>();
            // Set up authentication success callback
            authProvider.setAuthenticationSuccessCallback(() {
              // Navigate to home page after successful authentication
              GoRouter.of(context).go('/home');
            });
            return authProvider;
          },
        ),
        // Cart provider
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        // Additional providers will be added in Phase 4
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: _buildAppTheme(),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('vi', 'VN'), // Vietnamese
          Locale('en', 'US'), // English fallback
        ],
      ),
    );
  }

  /// Build the application theme
  ThemeData _buildAppTheme() {
    return ThemeData(
      useMaterial3: true,
      primaryColor: const Color(0xFF1976D2), // Vietnamese blue
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1976D2),
        secondary: Color(0xFFDC2626), // Red accent for fish sauce theme
        surface: Colors.white,
        surfaceContainer: Color(0xFFF8F9FA),
        error: Colors.red,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 2,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
