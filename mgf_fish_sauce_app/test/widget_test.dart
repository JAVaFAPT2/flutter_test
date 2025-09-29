// MGF Fish Sauce App Widget Tests
//
// This file contains basic widget tests for the Vietnamese fish sauce e-commerce app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mgf_fish_sauce_app/core/theme/app_theme.dart';
import 'package:mgf_fish_sauce_app/core/constants/app_constants.dart';

void main() {
  testWidgets('Vietnamese theme and text test', (WidgetTester tester) async {
    // Create a simple test widget with our theme
    await tester.pumpWidget(
      MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Nước Mắm MGF'),
                Text('Nước mắm truyền thống Việt Nam'),
                Icon(Icons.water_drop_outlined),
              ],
            ),
          ),
        ),
      ),
    );

    // Verify Vietnamese text rendering
    expect(find.text('Nước Mắm MGF'), findsOneWidget);
    expect(find.text('Nước mắm truyền thống Việt Nam'), findsOneWidget);
    expect(find.byIcon(Icons.water_drop_outlined), findsOneWidget);
    
    // Verify theme application
    final ThemeData theme = Theme.of(tester.element(find.text('Nước Mắm MGF')));
    expect(theme.brightness, equals(Brightness.light));
  });

  testWidgets('App constants test', (WidgetTester tester) async {
    // Test Vietnamese constants
    expect(AppConstants.appName, equals('Nước Mắm MGF'));
    expect(AppConstants.vietnameseLocaleCode, equals('vi'));
    expect(AppConstants.vietnameseCountryCode, equals('VN'));
    expect(AppConstants.vinhThaiBrand, equals('Vĩnh Thái'));
    expect(AppConstants.xuanThinhMauBrand, equals('Xuân Thịnh Mậu'));
  });
}
