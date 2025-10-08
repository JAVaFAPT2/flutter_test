import 'package:flutter/material.dart';
import 'package:vietnamese_fish_sauce_app/features/order/presentation/widgets/dynamic_timeline_svg.dart';

/// Order tracking timeline widget
///
/// Displays the visual timeline for order status progression using SVG asset.
/// Follows Single Responsibility Principle by handling only timeline visualization.
///
/// The timeline displays 6 status points based on current tracking status:
/// - Active points (orange) - completed statuses
/// - Inactive points (gray) - pending statuses
class OrderTrackingTimeline extends StatelessWidget {
  const OrderTrackingTimeline({
    super.key,
    this.height = 480, // Maximum height for much longer timeline
    this.width = 18,
    this.currentStatusIndex = 0,
    this.totalStatuses = 6,
  });

  /// Total height of the timeline
  final double height;

  /// Width of the timeline
  final double width;

  /// Current active status index (0-based)
  final int currentStatusIndex;

  /// Total number of status points
  final int totalStatuses;

  @override
  Widget build(BuildContext context) {
    return DynamicTimelineSvg(
      width: width,
      height: height,
      currentStatusIndex: currentStatusIndex,
      totalStatuses: totalStatuses,
    );
  }
}
