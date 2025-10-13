import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/core/constants/figma_assets.dart';

/// Date range display widget with hardcoded dates and calendar icons
class OrderDateRange extends StatelessWidget {
  const OrderDateRange({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First date with calendar icon
          Row(
            children: [
              Image.asset(
                FigmaAssets.calendarIcon,
                width: 16,
                height: 16,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Color(0xFF030303),
                  );
                },
              ),
              const SizedBox(width: 4),
              const Text(
                '01/10/2024',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF030303),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),

          // Dash separator
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '-',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF030303),
                fontFamily: 'Poppins',
              ),
            ),
          ),

          // Second date with calendar icon
          Row(
            children: [
              const Text(
                '15/10/2024',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF030303),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                FigmaAssets.calendarIcon,
                width: 16,
                height: 16,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Color(0xFF030303),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
