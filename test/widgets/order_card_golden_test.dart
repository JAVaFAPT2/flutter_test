import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/entities/order.dart'
    as domain;
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_card.dart';

void main() {
  testWidgets('OrderCard displays code, date, status, and total',
      (tester) async {
    final order = domain.Order(
      id: '1',
      code: '#TEST-1',
      createdAt: DateTime(2024, 1, 2),
      status: 'delivered',
      total: 123000,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SizedBox()),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OrderCard(order: order),
        ),
      ),
    );

    expect(find.text('#TEST-1'), findsOneWidget);
    expect(find.text('02/01/2024'), findsOneWidget);
    expect(find.text('delivered'), findsOneWidget);
    expect(find.text('123000 đ'), findsOneWidget);
  });
}
