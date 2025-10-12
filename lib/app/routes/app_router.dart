import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
import 'package:vietnamese_fish_sauce_app/features/profile/presentation/views/change_password_page.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/views/order_confirmation_page.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/views/order_history_page.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/views/order_page.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/views/order_detail_page.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/views/checkout_step2_page.dart';
import 'package:vietnamese_fish_sauce_app/features/cart/presentation/views/checkout_step3_page.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/views/order_tracking_page.dart';
import 'package:vietnamese_fish_sauce_app/features/support/presentation/views/customer_support_page.dart';
import 'package:vietnamese_fish_sauce_app/features/support/presentation/views/support_chat_page.dart';
import 'package:vietnamese_fish_sauce_app/features/notification/presentation/views/notification_page.dart';

/// Application router configuration using Go Router
class AppRouter {
  // Dev-only flag to bypass auth redirects. Set via --dart-define=AUTH_BYPASS_DEV=false to disable
  static const bool kAuthBypassDev = bool.fromEnvironment(
    'AUTH_BYPASS_DEV',
    defaultValue: true,
  );
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
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const OrderPage(),
      ),
      GoRoute(
        path: '/checkout-step2',
        name: 'checkout-step2',
        builder: (context, state) => const CheckoutStep2Page(),
      ),
      GoRoute(
        path: '/checkout-step3',
        name: 'checkout-step3',
        builder: (context, state) => const CheckoutStep3Page(),
      ),
      GoRoute(
        path: '/order/:id',
        name: 'order-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return OrderDetailPage(orderId: id);
        },
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
      GoRoute(
        path: '/change-password',
        name: 'change-password',
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: '/order-tracking/:orderId',
        name: 'order-tracking',
        builder: (context, state) {
          final orderId = state.pathParameters['orderId']!;
          return OrderTrackingPage(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/customer-support',
        name: 'customer-support',
        builder: (context, state) => const CustomerSupportPage(),
      ),
      GoRoute(
        path: '/support-chat',
        name: 'support-chat',
        builder: (context, state) {
          final topic =
              (state.extra as String?) ?? 'Trò chuyện với nhân viên tư vấn';
          return SupportChatPage(topic: topic);
        },
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationPage(),
      ),
      // Additional routes for authenticated users will be added later
    ],
    redirect: _handleRedirect,
    refreshListenable: _AuthRefreshListenable(),
  );

  /// Handle route redirection based on authentication state
  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    // In dev, allow navigation without auth
    if (kAuthBypassDev) {
      return null;
    }
    final authBloc = context.read<AuthBloc>();
    final isAuthenticated = authBloc.state.isAuthenticated;
    final isPublicRoute = state.matchedLocation == intro;
    final isAuthRoute = state.matchedLocation == login ||
        state.matchedLocation == register ||
        isPublicRoute;
    final isHomeRoute = state.matchedLocation == home;
    final isProductRoute = state.matchedLocation.startsWith('/product/');
    final isProductsRoute = state.matchedLocation == '/products';
    // Allow access to home, products, product detail, and cart pages regardless of auth state
    final isCartRoute = state.matchedLocation == '/cart';
    final isCheckoutRoute = state.matchedLocation == '/checkout';
    final isCheckoutStep2Route = state.matchedLocation == '/checkout-step2';
    final isOrdersRoute = state.matchedLocation == '/orders';

    if (isHomeRoute ||
        isProductRoute ||
        isProductsRoute ||
        isCartRoute ||
        isOrdersRoute ||
        isCheckoutStep2Route ||
        isCheckoutRoute) {
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
