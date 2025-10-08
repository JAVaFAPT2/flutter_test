import 'package:flutter/material.dart';
import '../../domain/entities/order_tracking_status.dart';

class StatusStepWidget extends StatelessWidget {
  const StatusStepWidget({
    super.key,
    required this.status,
    required this.isActive,
  });

  final OrderTrackingStatus status;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF0B8B50) : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              status.icon,
              color: isActive ? Colors.white : Colors.grey,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isActive ? const Color(0xFF0B8B50) : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusConnector extends StatelessWidget {
  const StatusConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        height: 20,
        width: 2,
        color: Colors.grey.shade300,
      ),
    );
  }
}
