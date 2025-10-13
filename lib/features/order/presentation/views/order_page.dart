import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/shared/widgets/custom_bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/shared/cubit/navigation_cubit.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_event.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_state.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:vietnamese_fish_sauce_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_filters.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_card.dart';
import 'package:vietnamese_fish_sauce_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_search_bar.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_date_range.dart';

/// Orders page - Step 1: Scaffold with header/background/empty per Figma
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigation(context),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              FigmaAssets.orderTrackingBackground,
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
                  // Header with logo, greeting, and avatar
                  const HomeAppBar(),
                  const _SeedOrdersOnce(),

                  const SizedBox(height: 8),

                  // Search bar
                  const OrderSearchBar(),

                  const SizedBox(height: 8),

                  // Title
                  const Text(
                    'Đơn hàng',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF030303),
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Date range
                  const OrderDateRange(),

                  const SizedBox(height: 8),

                  // Filter tabs
                  const OrderFilters(),

                  const SizedBox(height: 8),

                  // Orders list in white box
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFFD9D9D9)),
                      ),
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
                          if (state.filteredOrders.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.receipt_long,
                                    size: 80,
                                    color: Color(0xFFBBBBBB),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    AppStrings.noOrdersInPeriod,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFBBBBBB),
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Poppins',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: state.filteredOrders.length,
                            itemBuilder: (context, index) {
                              final order = state.filteredOrders[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: OrderCard(order: order),
                              );
                            },
                          );
                        },
                      ),
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

  Widget _buildBottomNavigation(BuildContext context) {
    return CustomBottomNavigation(
      items: [
        BottomNavItem(
          icon: 'assets/figma_exports/cart_icon.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () => context.read<NavigationCubit>().navigateToCart(context),
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/menu_box.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () =>
              context.read<NavigationCubit>().navigateToOrders(context),
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/bell_menu.png',
          width: 40,
          height: 40,
          scale: 1.0,
          badge: 1,
          onTap: () =>
              context.read<NavigationCubit>().navigateToNotifications(context),
        ),
        BottomNavItem(
          icon: 'assets/figma_exports/profile_menu.png',
          width: 40,
          height: 40,
          scale: 1.0,
          onTap: () =>
              context.read<NavigationCubit>().navigateToProfile(context),
        ),
      ],
      centerItem: CenterNavItem(
        icon: 'assets/figma_exports/home_menu.png',
        size: 65,
        innerSize: 45,
        iconSize: 26,
        onTap: () => context.read<NavigationCubit>().navigateToHome(context),
        backgroundColor: const Color(0xFF004917), // Dark green
      ),
      height: 85.0, // Slightly increased height for better spacing
      selectedIndex: 1, // Orders tab is selected
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
        'customerName': 'Nguyen Van A',
      },
      {
        'code': '#MGF-0002',
        'status': 'shipping',
        'total': 259000,
        'customerName': 'Tran Thi B',
      },
      {
        'code': '#MGF-0003',
        'status': 'delivered',
        'total': 99000,
        'customerName': 'Le Van C',
      },
      {
        'code': '#MGF-0004',
        'status': 'cancelled',
        'total': 149000,
        'customerName': 'Pham Thi D',
      },
      {
        'code': '#MGF-0005',
        'status': 'confirmed',
        'total': 320000,
        'customerName': 'Hoang Van E',
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
