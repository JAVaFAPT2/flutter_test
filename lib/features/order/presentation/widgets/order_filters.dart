import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_event.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_state.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';

class OrderFilters extends StatelessWidget {
  const OrderFilters({super.key});

  static const List<_FilterDef> _filters = [
    _FilterDef(label: AppStrings.all, value: null),
    _FilterDef(label: AppStrings.pending, value: 'pending'),
    _FilterDef(label: AppStrings.shipping, value: 'shipping'),
    _FilterDef(label: AppStrings.delivered, value: 'delivered'),
    _FilterDef(label: AppStrings.cancelled, value: 'cancelled'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final f = _filters[index];
              final selected = state.activeStatus == f.value;
              return GestureDetector(
                onTap: () {
                  context.read<OrderBloc>().add(OrderFilterChanged(f.value));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFF004917) : Colors.white,
                    border: Border.all(color: const Color(0xFFBDBDBD)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    f.label,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _FilterDef {
  const _FilterDef({required this.label, required this.value});
  final String label;
  final String? value;
}
