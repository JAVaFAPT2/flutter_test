import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/product.dart';
import 'package:provider/provider.dart';

import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/order_confirmation_page.dart';
import '../pages/order_history_page.dart';
import '../pages/otp_verification_page.dart';
import '../pages/product_detail_page.dart';
import '../pages/products_page.dart';
import '../pages/profile_page.dart';
import '../pages/register_page.dart';
import '../pages/settings_page.dart';
import '../pages/intro_page.dart';
import '../providers/auth_provider.dart';

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
        path: '/product-detail',
        name: 'product-detail',
        builder: (context, state) {
          final product = state.extra as Product;
          return ProductDetailPage(product: product);
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
    final authProvider = context.read<AuthProvider>();
    final isAuthenticated = authProvider.state.isAuthenticated;
    final isPublicRoute = state.matchedLocation == intro;
    final isAuthRoute = state.matchedLocation == login ||
        state.matchedLocation == register ||
        isPublicRoute;

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
    // Listen to auth provider changes
    // This will be set up when the app initializes
  }
}
