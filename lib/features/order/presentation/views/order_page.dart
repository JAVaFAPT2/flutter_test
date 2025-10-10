import 'package:flutter/material.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_event.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_state.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:vietnamese_fish_sauce_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_filters.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_card.dart';

/// Orders page - Step 1: Scaffold with header/background/empty per Figma
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavigation(),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              FigmaAssets.background,
              fit: BoxFit.cover,
            ),
          ),

          // Optional green overlay if present on Figma like cart/auth
          Positioned(
            left: 0,
            right: 0,
            bottom: -180,
            child: Image.asset(
              FigmaAssets.graphicGreen,
              width: double.infinity,
              height: 680,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: BlocProvider(
              create: (_) => OrderBloc(
                getOrders: GetOrdersUseCase(
                  OrderRepositoryImpl(FakeFirestore.instance),
                ),
              )..add(const OrderLoadRequested()),
              child: Column(
                children: [
                  _buildHeader(context),
                  const _SeedOrdersOnce(),
                  const SizedBox(height: 8),
                  const OrderFilters(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state.errorMessage != null) {
                          return Center(
                            child: Text(
                              state.errorMessage!,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }
                        if (state.orders.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.receipt_long,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  AppStrings.orderEmpty,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: const Color(0xFF9E9E9E),
                                        fontStyle: FontStyle.italic,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 16),
                          itemCount: state.orders.length,
                          itemBuilder: (context, index) {
                            final order = state.orders[index];
                            return OrderCard(order: order);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            ),
          ),
          const Spacer(),
          const Text(
            'ĐƠN HÀNG',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Container(
            width: 43,
            height: 43,
            decoration: const BoxDecoration(
              color: Color(0xFF900407),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _SeedOrdersOnce extends StatefulWidget {
  const _SeedOrdersOnce();

  @override
  State<_SeedOrdersOnce> createState() => _SeedOrdersOnceState();
}

class _SeedOrdersOnceState extends State<_SeedOrdersOnce> {
  bool _seeded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_seeded) return;
    _seeded = true;
    // Seed sample orders for demo
    FakeFirestore.instance.seedOrders([
      {
        'code': '#MGF-0001',
        'status': 'pending',
        'total': 189000,
      },
      {
        'code': '#MGF-0002',
        'status': 'shipping',
        'total': 259000,
      },
      {
        'code': '#MGF-0003',
        'status': 'delivered',
        'total': 99000,
      },
      {
        'code': '#MGF-0004',
        'status': 'cancelled',
        'total': 149000,
      },
    ]).then((_) {
      if (mounted) {
        context.read<OrderBloc>().add(const OrderLoadRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
