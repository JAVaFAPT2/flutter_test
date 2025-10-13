import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/app_strings.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/bloc/order_event.dart';

/// Search bar widget for order page with real-time search functionality
class OrderSearchBar extends StatelessWidget {
  const OrderSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 29,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF3C3C3C)),
          borderRadius:
              BorderRadius.circular(57), // Very rounded corners as per Figma
        ),
        child: Row(
          children: [
            // Search icon (left)
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 7),
              child: Image.asset(
                FigmaAssets.searchIconSnap,
                width: 17,
                height: 17,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.search,
                    size: 17,
                    color: Color(0xFFBBBBBB),
                  );
                },
              ),
            ),

            // Text field
            Expanded(
              child: TextField(
                onChanged: (query) {
                  context.read<OrderBloc>().add(OrderSearchQueryChanged(query));
                },
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF030303),
                  fontFamily: 'Poppins',
                ),
                decoration: InputDecoration(
                  hintText: AppStrings.searchOrdersHint,
                  hintStyle: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFBBBBBB),
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
