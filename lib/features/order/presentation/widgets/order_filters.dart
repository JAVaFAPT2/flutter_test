import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_event.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_state.dart';

class OrderFilters extends StatelessWidget {
  const OrderFilters({super.key});

  static const List<_FilterDef> _filters = [
    _FilterDef(label: 'Chờ xác nhận', value: 'pending'),
    _FilterDef(label: 'Chờ lấy hàng', value: 'confirmed'),
    _FilterDef(label: 'Đang giao hàng', value: 'shipping'),
    _FilterDef(label: 'Đã giao hàng', value: 'delivered'),
    _FilterDef(label: 'Đã hủy', value: 'cancelled'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return Column(
            children: [
              // Tab text row with individual containers
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _filters.asMap().entries.map((entry) {
                    final index = entry.key;
                    final filter = entry.value;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<OrderBloc>()
                              .add(OrderFilterChanged(filter.value));
                        },
                        child: Container(
                          key: ValueKey('tab_$index'),
                          child: Center(
                            child: Text(
                              filter.label,
                              style: const TextStyle(
                                color: Color(0xFF030303),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Progress bar with dots
              Container(
                height: 20,
                child: Stack(
                  children: [
                    // Background gray line
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 8,
                      child: Container(
                        height: 2,
                        color: const Color(0xFFE0E0E0), // Light gray
                      ),
                    ),

                    // Active progress line
                    if (state.activeStatus != null)
                      _ProgressLine(
                        activeStatus: state.activeStatus!,
                        filters: _filters,
                      ),

                    // Dots for each step
                    _StatusDots(
                      activeStatus: state.activeStatus,
                      filters: _filters,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({
    required this.activeStatus,
    required this.filters,
  });

  final String activeStatus;
  final List<_FilterDef> filters;

  @override
  Widget build(BuildContext context) {
    final activeIndex = filters.indexWhere((f) => f.value == activeStatus);
    if (activeIndex == -1) return const SizedBox.shrink();

    return Positioned(
      left: 0,
      right: 0,
      top: 8,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: ((activeIndex + 0.5) / filters.length).clamp(0.0, 1.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 2,
            color: const Color(0xFFFF9800), // Orange color
          ),
        ),
      ),
    );
  }
}

class _StatusDots extends StatelessWidget {
  const _StatusDots({
    required this.activeStatus,
    required this.filters,
  });

  final String? activeStatus;
  final List<_FilterDef> filters;

  @override
  Widget build(BuildContext context) {
    final activeIndex = activeStatus != null
        ? filters.indexWhere((f) => f.value == activeStatus)
        : -1;

    return LayoutBuilder(
      builder: (context, constraints) {
        final tabWidth = constraints.maxWidth / filters.length;

        return Stack(
          children: filters.asMap().entries.map((entry) {
            final index = entry.key;
            final isActive = index == activeIndex;
            final isPast = index < activeIndex;

            final dotPosition = (index * tabWidth) + (tabWidth / 2) - 5;

            return Positioned(
              left: dotPosition,
              // Center the dot on the progress line (line center is at top 8 + height 2/2 = 9)
              top: 4,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  // Active: solid orange; Past: transparent to reveal orange line; Future: white
                  color: isActive
                      ? const Color(0xFFFF9800)
                      : isPast
                          ? Colors.transparent
                          : Colors.white,
                  shape: BoxShape.circle,
                  // No border for active or past; gray border for future
                  border: isActive || isPast
                      ? null
                      : Border.all(
                          color: const Color(0xFFE0E0E0),
                          width: 2,
                        ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _FilterDef {
  const _FilterDef({required this.label, required this.value});
  final String label;
  final String value;
}
