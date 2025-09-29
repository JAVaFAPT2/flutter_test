// This is a comprehensive test suite for the Vietnamese Fish Sauce E-commerce App.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:vietnamese_fish_sauce_app/main.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/providers/auth_provider.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/providers/cart_provider.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/pages/login_page.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/pages/home_page.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/pages/products_page.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/pages/cart_page.dart';
import 'package:vietnamese_fish_sauce_app/src/presentation/pages/profile_page.dart';

void main() {
  group('Vietnamese Fish Sauce E-commerce App Tests', () {
    testWidgets('App launches successfully', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const VietnameseFishSauceApp());

      // Verify that the app launches without errors
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Login page displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(
                loginUseCase: MockLoginUseCase(),
                registerUseCase: MockRegisterUseCase(),
                secureStorage: MockSecureStorage(),
              ),
            ),
          ],
          child: const MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Verify login page elements
      expect(find.text('Đăng nhập'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Phone and password fields
      expect(find.byType(ElevatedButton), findsOneWidget); // Login button
    });

    testWidgets('Products page displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductsPage(),
        ),
      );

      // Verify products page elements
      expect(find.text('Sản phẩm'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.filter_list), findsOneWidget);
    });

    testWidgets('Cart page displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<CartProvider>(
              create: (_) => CartProvider(),
            ),
          ],
          child: const MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      // Verify cart page elements
      expect(find.text('Giỏ hàng'), findsOneWidget);
    });

    testWidgets('Profile page displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(
                loginUseCase: MockLoginUseCase(),
                registerUseCase: MockRegisterUseCase(),
                secureStorage: MockSecureStorage(),
              ),
            ),
          ],
          child: const MaterialApp(
            home: ProfilePage(),
          ),
        ),
      );

      // Verify profile page elements
      expect(find.text('Thông tin cá nhân'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsWidgets);
    });

    testWidgets('Home page navigation works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(
                loginUseCase: MockLoginUseCase(),
                registerUseCase: MockRegisterUseCase(),
                secureStorage: MockSecureStorage(),
              ),
            ),
            ChangeNotifierProvider<CartProvider>(
              create: (_) => CartProvider(),
            ),
          ],
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      // Verify home page elements
      expect(find.text('Nước Mắm MGF'), findsOneWidget);
      expect(find.text('Sản phẩm'), findsOneWidget);
      expect(find.text('Giỏ hàng'), findsOneWidget);
      expect(find.text('Hồ sơ'), findsOneWidget);
    });
  });
}

// Mock classes for testing
class MockLoginUseCase {
  Future<void> execute({required String phone, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }
}

class MockRegisterUseCase {
  Future<void> execute({
    required String phone,
    required String password,
    required String fullName,
    String? email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }
}

class MockSecureStorage {
  Future<String?> read({required String key}) async {
    return null;
  }

  Future<void> write({required String key, required String value}) async {}

  Future<void> delete({required String key}) async {}

  Future<bool> containsKey({required String key}) async {
    return false;
  }

  Future<void> deleteAll() async {}
}
