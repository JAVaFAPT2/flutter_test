import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/core/constants/app_constants.dart';
import 'src/core/di/injection_container.dart' as di;
import 'src/presentation/routes/app_router.dart';
import 'core/design_system/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.getIt<AuthBloc>()),
        BlocProvider<ProductBloc>(create: (_) => di.getIt<ProductBloc>()),
        BlocProvider<CartBloc>(create: (_) => di.getIt<CartBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) => prev.isAuthenticated != curr.isAuthenticated,
        listener: (context, state) {
          if (state.isAuthenticated) {
            GoRouter.of(context).go('/home');
          }
        },
        child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme.light(),
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
      ),
    );
  }
}
