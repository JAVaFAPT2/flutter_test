import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_event.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_state.dart';

void main() {
  group('OrderBloc', () {
    late FakeFirestore store;
    late OrderBloc bloc;

    setUp(() async {
      store = FakeFirestore.instance;
      await store.seedOrders([
        {'code': '#A', 'status': 'pending', 'total': 100000},
        {'code': '#B', 'status': 'delivered', 'total': 200000},
      ]);
      bloc = OrderBloc(
        getOrders: GetOrdersUseCase(OrderRepositoryImpl(store)),
      );
    });

    tearDown(() {
      // No dispose necessary for simple bloc
    });

    test('initial state', () {
      expect(bloc.state, const OrderState());
    });

    blocTest<OrderBloc, OrderState>(
      'loads orders on OrderLoadRequested',
      build: () => bloc,
      act: (b) => b.add(const OrderLoadRequested()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const OrderState(isLoading: true, errorMessage: null, orders: []),
        isA<OrderState>().having((s) => s.isLoading, 'loading', false).having(
              (s) => s.orders.length,
              'orders length',
              2,
            ),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'filters by status on OrderFilterChanged',
      build: () => bloc,
      act: (b) async {
        b.add(const OrderLoadRequested());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        b.add(const OrderFilterChanged('delivered'));
      },
      wait: const Duration(milliseconds: 30),
      expect: () => predicate<List<OrderState>>((states) {
        // Last state should have only delivered orders
        final last = states.last;
        return last.isLoading == false && last.orders.length == 1;
      }),
    );
  });
}
