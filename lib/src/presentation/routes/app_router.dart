import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:vietnamese_fish_sauce_app/src/domain/entities/product.dart'; // Removed - using productId instead

// Feature imports - Clean Architecture
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/views/login_page.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/views/register_page.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/views/otp_verification_page.dart';
import 'package:vietnamese_fish_sauce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/intro/presentation/views/intro_page.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/views/home_page.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/views/cart_page.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/views/checkout_page.dart';
import 'package:vietnamese_fish_sauce_app/features/product/presentation/views/products_page.dart';
import 'package:vietnamese_fish_sauce_app/features/product/presentation/views/product_detail_page.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/presentation/views/profile_page.dart';
import 'package:vietnamese_fish_sauce_app/features/profile/presentation/views/settings_page.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/views/order_confirmation_page.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/views/order_history_page.dart';

/// Application router configuration using Go Router
class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String intro = '/intro';
  static const String home = '/home';

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: intro,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: intro,
        name: 'intro',
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/otp-verification',
        name: 'otp-verification',
        builder: (context, state) {
          final phone = state.extra as String;
          return OtpVerificationPage(phone: phone);
        },
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductsPage(),
      ),
      GoRoute(
        path: '/product/:id',
        name: 'product-detail',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductDetailPage(productId: productId);
        },
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        path: '/order-confirmation',
        name: 'order-confirmation',
        builder: (context, state) => const OrderConfirmationPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/order-history',
        name: 'order-history',
        builder: (context, state) => const OrderHistoryPage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      // Additional routes for authenticated users will be added in Phase 7
    ],
    redirect: _handleRedirect,
    refreshListenable: _AuthRefreshListenable(),
  );

  /// Handle route redirection based on authentication state
  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final isAuthenticated = authBloc.state.isAuthenticated;
    final isPublicRoute = state.matchedLocation == intro;
    final isAuthRoute = state.matchedLocation == login ||
        state.matchedLocation == register ||
        isPublicRoute;
    final isHomeRoute = state.matchedLocation == home;
    final isProductRoute = state.matchedLocation.startsWith('/product/');
    //TODO: Update back to using auth state instead of allowing access to home and product detail pages regardless of auth state
    // Allow access to home and product detail pages regardless of auth state
    if (isHomeRoute || isProductRoute) {
      return null;
    }

    // If not authenticated and not on public/auth routes, redirect to intro
    if (!isAuthenticated && !isAuthRoute) {
      return intro;
    }

    // If authenticated and on public/auth routes, redirect to home
    if (isAuthenticated && isAuthRoute) {
      return home;
    }

    // No redirect needed
    return null;
  }
}

/// Listenable for Go Router to refresh when auth state changes
class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable() {
    // In Bloc, GoRouter refresh can be wired via router refresh stream; placeholder
  }
}
