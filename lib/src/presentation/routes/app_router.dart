import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/products_page.dart';
import '../pages/register_page.dart';
import '../providers/auth_provider.dart';

/// Application router configuration using Go Router
class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: login,
    debugLogDiagnostics: true,
    routes: [
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
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductsPage(),
      ),
      // Additional routes for authenticated users will be added in Phase 3
    ],
    redirect: _handleRedirect,
    refreshListenable: _AuthRefreshListenable(),
  );

  /// Handle route redirection based on authentication state
  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final authProvider = context.read<AuthProvider>();
    final isAuthenticated = authProvider.state.isAuthenticated;
    final isAuthRoute =
        state.matchedLocation == login || state.matchedLocation == register;

    // If not authenticated and not on auth routes, redirect to login
    if (!isAuthenticated && !isAuthRoute) {
      return login;
    }

    // If authenticated and on auth routes, redirect to home
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
