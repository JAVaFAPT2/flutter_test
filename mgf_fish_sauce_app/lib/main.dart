import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/dependency_injection.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Setup dependency injection
  await setupDependencyInjection();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MGFFishSauceApp());
}

class MGFFishSauceApp extends StatelessWidget {
  const MGFFishSauceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Vietnamese Localization
      locale: const Locale(AppConstants.vietnameseLocaleCode,
          AppConstants.vietnameseCountryCode),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale(AppConstants.vietnameseLocaleCode,
            AppConstants.vietnameseCountryCode),
      ],

      // Vietnamese Fish Sauce Brand Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,

      // Initial screen - Splash screen
      home: const SplashPage(),

      // Global Material App configuration
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler:
                const TextScaler.linear(1.0), // Prevent system font scaling
          ),
          child: child!,
        );
      },
    );
  }
}
