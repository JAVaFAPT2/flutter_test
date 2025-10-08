import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';
import 'package:vietnamese_fish_sauce_app/core/fake/fake_firestore.dart';
import 'package:vietnamese_fish_sauce_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:vietnamese_fish_sauce_app/features/order/domain/usecases/get_order_tracking_usecase.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_tracking_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_tracking_event.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_tracking_state.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_tracking_bottom_navigation.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_tracking_status_item.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/order_tracking_timeline.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key, required this.orderId});

  final String orderId;

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderTrackingBloc(
        getOrderTracking: GetOrderTrackingUseCase(
          OrderRepositoryImpl(FakeFirestore.instance),
        ),
      ),
      child: _OrderTrackingContent(orderId: widget.orderId),
    );
  }
}

class _OrderTrackingContent extends StatefulWidget {
  const _OrderTrackingContent({required this.orderId});

  final String orderId;

  @override
  State<_OrderTrackingContent> createState() => _OrderTrackingContentState();
}

class _OrderTrackingContentState extends State<_OrderTrackingContent> {
  @override
  void initState() {
    super.initState();
    // Dispatch after first frame to ensure BlocProvider is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<OrderTrackingBloc>()
          .add(LoadOrderTracking(orderId: widget.orderId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderTrackingBloc, OrderTrackingState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.errorMessage != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.errorMessage}'),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<OrderTrackingBloc>()
                          .add(LoadOrderTracking(orderId: widget.orderId));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        final tracking = state.orderTracking;
        if (tracking == null) {
          return const Scaffold(body: Center(child: Text('No tracking data')));
        }

        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  AppAssets.orderTrackingBackground,
                  fit: BoxFit.cover,
                ),
              ),
              // Main Content
              SafeArea(
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 52, vertical: 16),
                      child: Row(
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: () {
                              // Try to pop first, if that fails, go to orders page
                              if (Navigator.of(context).canPop()) {
                                context.pop();
                              } else {
                                context.go('/orders');
                              }
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(),
                              child: Image.asset(
                                AppAssets.orderTrackingBackButton,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Title
                          const Text(
                            AppStrings.orderTrackingTitle,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(width: 48), // Balance the back button
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            // Map Section
                            Container(
                              height: 334,
                              width: 331,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 54),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AppAssets.orderTrackingMap,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Status Timeline - Phase 4: Timeline visualization
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 52),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Timeline SVG - Dynamic based on tracking data
                                  OrderTrackingTimeline(
                                    height:
                                        480, // Maximum height for much longer timeline
                                    width: 18,
                                    currentStatusIndex:
                                        tracking.currentStatusIndex,
                                    totalStatuses: tracking.statuses.length,
                                  ),
                                  const SizedBox(width: 16),
                                  // Status Items - Dynamic based on tracking data
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _buildStatusItems(tracking),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    // Bottom Navigation
                    const OrderTrackingBottomNavigation(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds dynamic status items based on order tracking data
  /// Follows Clean Architecture and DRY principles
  List<Widget> _buildStatusItems(tracking) {
    final statuses = tracking.statuses;
    final currentIndex = tracking.currentStatusIndex;
    final List<Widget> widgets = [];

    for (int index = 0; index < statuses.length; index++) {
      final status = statuses[index];
      final isActive = index <= currentIndex;
      final isCurrent = index == currentIndex;

      widgets.add(
        OrderTrackingStatusItem(
          title: status.subtitle,
          subtitle: status.title,
          isActive: isActive,
          isCurrent: isCurrent,
        ),
      );

      // Add spacing between items (except after the last item)
      // Reduced spacing to match Figma design exactly
      if (index < statuses.length - 1) {
        widgets
            .add(const SizedBox(height: 12)); // Much closer spacing like Figma
      }
    }

    return widgets;
  }
}
